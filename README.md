This is the final capstone project for Udacity Cloud DevOps Engineer NanoDegree Program 


In this project we will deploy Udacity - Udagram application on AWS EKS cluster


Step 1 

Create infrastructure for Jenkins Server using CloudFormation 

Run  ./create.sh <stackname> Jenkins-infra.yml Jenkins-params.json  

The script will create complete infrastructure for our Jenkins server 

Step 2 

Complete Jenkins Setup and create pipeline 

Step 3 

Build Pipeline After 1st successful build remove or comment out scripts in step “Create Kubernetes Cluster - One Time Setup”

Step 4 

Access the app from your <load balancer url>:8000
