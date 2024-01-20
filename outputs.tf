output "sqs_arn" {
  value = aws_sqs_queue.main.arn
}

output "sqs_url" {
  value = aws_sqs_queue.main.url
}

output "dlq_sqs_arn" {
  value = var.enable_dlq == true ? aws_sqs_queue.main_deadletter_queue[0].arn : null
}

output "dlq_sqs_url" {
  value = var.enable_dlq == true ? aws_sqs_queue.main_deadletter_queue[0].url : null
}
