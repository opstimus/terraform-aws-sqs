output "sqs_arn" {
  value = aws_sqs_queue.main.arn
}

output "sql_url" {
  value = aws_sqs_queue.main.url
}
