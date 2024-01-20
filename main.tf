resource "aws_sqs_queue" "main" {
  name                       = var.enable_fifo == true ? "${var.project}-${var.environment}-${var.name}.fifo" : "${var.project}-${var.environment}-${var.name}"
  fifo_queue                 = var.enable_fifo
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  policy                     = var.policy
  deduplication_scope   = var.enable_fifo == true && var.enable_high_throughput == true ? "messageGroup" : ((var.enable_fifo == true && var.enable_high_throughput == false) ? "queue" : null)
  fifo_throughput_limit = var.enable_fifo == true && var.enable_high_throughput == true ? "perMessageGroupId" : ((var.enable_fifo == true && var.enable_high_throughput == false) ? "perQueue" : null)
}

resource "aws_sqs_queue_redrive_policy" "main" {
  count = var.enable_dlq ? 1 : 0
  queue_url = aws_sqs_queue.main.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.main_deadletter_queue[0].arn
    maxReceiveCount     = var.maxReceiveCount
  })
}

resource "aws_sqs_queue" "main_deadletter_queue" {
  count      = var.enable_dlq ? 1 : 0
  name       = var.enable_fifo == true ? "${var.project}-${var.environment}-${var.name}-deadletter-queue.fifo" : "${var.project}-${var.environment}-${var.name}-deadletter-queue"
  fifo_queue = var.enable_fifo
}

resource "aws_sqs_queue_redrive_allow_policy" "main" {
  count     = var.enable_dlq ? 1 : 0
  queue_url = aws_sqs_queue.main_deadletter_queue[0].id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.main.arn]
  })
}
