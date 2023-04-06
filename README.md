# React Microfrontend

## Introduction

This repository demonstrates a microfrontend architecture utilizing both React and Vue applications.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [aws remote backend S3](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
- [GitHub OpenID Connect with AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)

## Build

1. Install npm packages on all 4 projects (e.g., run `npm install` from within the `container`, `marketing`, `auth`, and `dashboard` apps).
2. Run `make build -j` to run all projects locally in both isolation and integrated modes.
   1. `Container` can be accessed at `localhost:8080` and is the fully integrated microfrontend app.
   2. `Marketing` can be accessed at `localhost:8081` and is the isolated marketing app.
   3. `Auth` can be accessed at `localhost:8082` and is the isolated auth app.
   4. `Dashboard` can be accessed at `localhost:8083` and is the isolated dashboard app.

## Deploy

All GitHub workflows are attached to this project and require a few steps to be completed in order to properly deploy.

1. Create an AWS account and follow the steps outline in the prerequisites section for `GitHub OpenID Connect with AWS` to allow GitHub to deploy to AWS using RBAC.
2. Configure S3 remote backend by following the steps outlined in the prerequisites section for `aws remote backend S3`.
3. Alter the terraform files provided to connect to your remote backend and update the names of your CloudFront CDN and S3 bucket (as the S3 bucket name must be globally unique).
4. Authenticate to AWS from the cli (e.g., `aws sso login --profile MY_PROFILE`).
5. Provision infrastructure using Terraform by running `terraform apply --auto-approve`.
6. Define the following secrets in your GitHub repository for this project
   1. `AWS_S3_BUCKET_NAME` The name of the S3 bucket created in the previous step.
   2. `CLOUDFRONT_DISTRIBUTION_ID` The CloudFront distribution ID returned by Terraform outputs in the previous step.
   3. `PRODUCTION_DOMAIN` The CloudFront domain name returned by Terraform outputs (or your personal domain) in the previous step (be sure to remove the trailing forward slash when adding to GitHub).
7. Run all four pipelines either manually or by making some small alteration to files in all four project directories which will trigger the CI/CD process (`container`, `marketing`, `auth`, `dashboard`).
