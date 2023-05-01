## Terraform Project Examples

This repository serves as an example of how a Terraform AWS infrastructure would operate in a practical setting.

### Repository Structure

The repository is divided into modules and projects. Modules are essentially pre-packaged lego pieces of different AWS resources, which can be used in different projects. Projects utilize these modules to create production-like infrastructure that works and can be used.

### Modules

Modules are designed to be reusable and customizable. They are essentially packages of Terraform code that can be used to create specific AWS resources. For example, there may be a module for creating an S3 bucket, or a module for creating an EC2 instance. These modules are designed to be easily used in different projects, and can be customized to meet the specific needs of each project.

### Projects

Projects are essentially collections of modules that are used to create a complete infrastructure. They can be thought of as blueprints for a production-like infrastructure. Projects are designed to be easily replicable, so that the same infrastructure can be created across different environments, such as development, staging, and production.

Overall, this repository serves as a valuable resource for those looking to learn more about how to use Terraform to create AWS infrastructure projects. It demonstrates the power and flexibility of Terraform, and provides a solid foundation for those looking to create their own Terraform-based infrastructure.

**Project list**

- eks-lb-vpc:
Implementing a private EKS cluster with a custom VPC and the aws-load-balancer-controller installed
- multiple-lambdas-one-log:
Implementing two Lambda functions using a general log stream.
- sqs-triggering-lambda:
Implementing a Lambda function that is triggered by an SQS queue.
