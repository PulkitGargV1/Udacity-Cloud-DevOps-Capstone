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
	stage('Configure kubectl') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						aws eks --region us-east-1 update-kubeconfig --name apicluster
					'''
				}
			}
		}    
        stage('Remove Unused docker image') {
            steps {
                sh 'docker image prune'
            }
        }
        }
    }
