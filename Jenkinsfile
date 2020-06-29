pipeline {
    environment {
        USER_CREDENTIALS = credentials('dockerhub')
    }
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'chmod +x ./run_docker.sh'
                sh './run_docker.sh'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh 'chmod +x ./upload_docker.sh'
                sh './upload_docker.sh $USER_CREDENTIALS_USR $USER_CREDENTIALS_PSW'
            }
        }
	    
        stage('Create Kubernetes Cluster') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						eksctl create cluster \
						--name apicluster \
						--version 1.16 \
						--nodegroup-name standard-workers \
						--node-type t2.small \
						--nodes 2 \
						--nodes-min 1 \
						--nodes-max 3 \
						--node-ami auto \
						--region us-east-1 \
						--zones us-east-1a \
						--zones us-east-1b \
						--zones us-east-1c \
					'''
				}
			}
		}

		stage('Configure kubectl') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						aws eks --region us-east-1 update-kubeconfig --name apicluster
					'''
				}
			}

        
        stage('Remove Unused docker image') {
            steps {
                sh 'docker image prune'
            }
        }
        }
    }
