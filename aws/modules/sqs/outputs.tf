output "queue_arn" {
    value = module.sqs.queue_arn
}

output "queue_name" {
    value = module.sqs.queue_name
}

output "queue_url" {
    value = module.sqs.queue_url
}

output "dead_letter_queue_arn" {
    value = module.sqs.dead_letter_queue_arn
}

output "dead_letter_queue_name" {
    value = module.sqs.dead_letter_queue_name
}

output "dead_letter_queue_url" {
    value = module.sqs.dead_letter_queue_url
}

