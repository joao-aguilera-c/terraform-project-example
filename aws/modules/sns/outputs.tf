output "subscriptions" {
    value = module.sns_topic.subscriptions
}

output "topic_arn" {
    value = module.sns_topic.topic_arn
}


output "topic_name" {
    value = module.sns_topic.topic_name
}

output "topic_owner" {
    value = module.sns_topic.topic_owner
}
