variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Service name"
}

variable "enable_dlq" {
  type    = bool
  default = false
}

variable "enable_fifo" {
  type        = bool
  default     = false
  description = "FIFO queue enable/disable"
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "The visibility timeout for the queue"
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "The number of seconds Amazon SQS retains a message"
  default     = 345600
}

variable "max_message_size" {
  type        = number
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  default     = 262144
}

variable "delay_seconds" {
  type        = number
  description = "The time in seconds that the delivery of all messages in the queue will be delayed"
  default     = 0
}

variable "receive_wait_time_seconds" {
  type        = number
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning"
  default     = 0
}

variable "policy" {
  type        = string
  description = "Policy"
  default     = null
}

variable "max_receive_count" {
  type        = number
  description = "The maxReceiveCount is the number of times a consumer tries receiving a message from a queue without deleting it before being moved to the dead-letter queue"
  default     = 5
}

variable "enable_high_throughput" {
  type    = bool
  default = false
}

variable "dlq_message_retention_seconds" {
  type        = number
  description = "The number of seconds Amazon SQS retains a message in DLQ"
  default     = 345600
}

# variable "deduplication_scope" {
#   type        = string
#   description = "Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup | queue"
#   default     = "queue"
# }

# variable "fifo_throughput_limit" {
#   type        = string
#   description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue | perMessageGroupId"
#   default     = "perQueue"
# }
