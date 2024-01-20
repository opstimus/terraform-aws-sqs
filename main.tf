resource "aws_sqs_queue" "main" {
  name                       = var.fifo_queue == true ? "${var.project}-${var.environment}-${var.name}.fifo" : "${var.project}-${var.environment}-${var.name}"
  fifo_queue                 = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  policy                     = var.policy
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.main_deadletter_queue.arn
    maxReceiveCount     = var.maxReceiveCount
  })
  deduplication_scope   = var.fifo_queue == true && var.enable_high_throughput == true ? "messageGroup" : ((var.fifo_queue == true && var.enable_high_throughput == false) ? "queue" : null)
  fifo_throughput_limit = var.fifo_queue == true && var.enable_high_throughput == true ? "perMessageGroupId" : ((var.fifo_queue == true && var.enable_high_throughput == false) ? "perQueue" : null)
}

resource "aws_sqs_queue" "main_deadletter_queue" {
  name       = var.fifo_queue == true ? "${var.project}-${var.environment}-${var.name}-deadletter-queue.fifo" : "${var.project}-${var.environment}-${var.name}-deadletter-queue"
  fifo_queue = var.fifo_queue
}

resource "aws_sqs_queue_redrive_allow_policy" "main" {
  queue_url = aws_sqs_queue.main_deadletter_queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.main.arn]
  })
}
