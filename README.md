# Devops Code Challenge

## Description
The goal of this code challenge is to provide a broad range of coverage across various skill sets.  The inability to complete this exercise independently does not constitute a failure.  It's merely designed to demostrate subject matter expertise and expose knowledge gaps.  This is a 'take home' challenge that should be completed prior to your technical interview.  You will be expected to review & execute your code during the technical interview.

## Pre-Requisites
- The Terraform CLI utility (tfenv is recommended https://github.com/tfutils/tfenv)

## Installation
1. ensure all pre-req's are installed
1. clone [this repository](https://github.com/Vic-ai/devops-python-sample-app)

## Instructions
Deploy our application in the form of a docker image onto the necessary infrastructure you will define with terraform. AWS is the target cloud provider.  You should be able to get all the way up to creating the plan for terraform.  When we pair to review your code we will provide you aws keys to use; Feel free to test deploying this into your personal AWS account to verify it's functionality until then.

To get started:
1. Fork this repository into your own github account and then clone it locally. When you're code is ready you'll submit a pull-request to our repository from your fork.
1. Define your infrastructure with terraform in the `terraform/` folder of this repo.
1. You will need to provision the following:
    - A remote backend for the tfstate file. Use S3.
    - An AWS ECR repository to push our app image to after it's built.
    - An AWS lightsail container service to deploy ^^.
    - Output the URL of our container service
1. Build the docker image from the python app you cloned above.
1. Tag the docker image with the ECR address & push the image to the ECR.
1. When applied, we should be able to curl & browse to the lightsail endpoint.
