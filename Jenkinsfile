pipeline {
	environment {
        USER_CREDENTIALS = credentials('docker-hub')
    	}
	agent any
	stages {

	stage('Lint HTML') {
		steps {
			sh 'tidy -q -e ./udagram/*.html'
		}
	}

	stage('Lint Dockerfile') {
		steps {
			sh 'hadolint --ignore DL3006 ./Dockerfile'
		}
	}
	
	stage('Build Docker Image') {
            steps {
                sh './run_docker.sh'
            }
        }
        
	stage('Push to Docker Hub') {
            steps {
                sh './upload_docker.sh $USER_CREDENTIALS_USR $USER_CREDENTIALS_PSW'
            }
        }
		
	stage('Create Kubernetes Cluster - One Time Setup ') {
		steps {
			withAWS(region:'us-east-1', credentials:'aws_credentials') 
			{
				//sh 'eksctl create cluster --name udagramcluster --version 1.16 --nodegroup-name standard-workers --node-type t2.small --nodes 2 --nodes-min 1 --nodes-max 3 --node-ami auto --region us-east-1 --zones us-east-1a --zones us-east-1b --zones us-east-1c '
				//sh 'aws eks --region us-east-1 update-kubeconfig --name udagramcluster'
			}
			}
		}
		
	stage('Deploy Container') {
		steps {
			withAWS(region:'us-east-1', credentials:'aws_credentials') 
			{
				sh 'kubectl apply -f ./eks.yml'
			}
		}
	}
	}
	
}
