output "iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.iam_user.iam_access_key_encrypted_secret
}

output "iam_access_key_encrypted_ses_smtp_password_v4" {
  description = "The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user.iam_access_key_encrypted_ses_smtp_password_v4
}

output "iam_access_key_id" {
  description = "The access key ID"
  value       = module.iam_user.iam_access_key_id
}

output "iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = module.iam_user.iam_access_key_key_fingerprint
}

output "iam_access_key_secret" {
  description = "The access key secret"
  value       = module.iam_user.iam_access_key_secret
}

output "iam_access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user.iam_access_key_ses_smtp_password_v4
}

output "iam_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value       = module.iam_user.iam_access_key_status
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = module.iam_user.iam_user_arn
}

output "iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.iam_user.iam_user_login_profile_encrypted_password
}

output "iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = module.iam_user.iam_user_login_profile_key_fingerprint
}

output "iam_user_login_profile_password" {
  description = "The user password"
  value       = module.iam_user.iam_user_login_profile_password
}

output "iam_user_name" {
  description = "The user's name"
  value       = module.iam_user.iam_user_name
}

output "iam_user_ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = module.iam_user.iam_user_ssh_key_fingerprint
}

output "iam_user_ssh_key_ssh_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = module.iam_user.iam_user_ssh_key_ssh_public_key_id
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = module.iam_user.iam_user_unique_id
}

output "keybase_password_decrypt_command" {
  description = "Decrypt user password command"
  value       = module.iam_user.keybase_password_decrypt_command
}

