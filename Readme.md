Prerequisite-
1) Docker installed on the system
2) Have an AWS account for deploying application


Steps to deploy application:
1) Configure your profile with AWS access and secret key or IAM(command : aws configure)
2) Create ECR repository by running below command
aws ecr create-repository \
    --repository-name afterpay-test \
    --image-scanning-configuration scanOnPush=true \
    --region ap-southeast-2
3) Download code from GitHub https://github.com/Cody-Var/codingchallenge.git
4) Change the directory to project workspace (downloaded in previous step)
5) Create docker image by running below command
docker build . -t afterpay-test
6) Tag docker image 
docker tag afterpay-test:latest {AWS _account_id}.dkr.ecr.ap-southeast-2.amazonaws.com/afterpay-test
7) Push docker image to ECR repository

aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin {AWS _account_id}.dkr.ecr.ap-southeast-2.amazonaws.com

docker push {AWS _account_id}.dkr.ecr.ap-southeast-2.amazonaws.com/afterpay-test

8) creating ECS cluster
aws cloudformation create-stack --stack-name afterpay-deployment --template-body file://afterpay-ecs.yml --capabilities CAPABILITY_NAMED_IAM --parameters 'ParameterKey=SubnetID,ParameterValue={subnet_id}’