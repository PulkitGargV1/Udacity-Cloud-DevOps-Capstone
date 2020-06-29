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
	
	stage('Set Current kubectl Context') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl config use-context arn:aws:eks:us-east-1:270263200429:cluster/apicluster
					'''
				}
			}
		}

		stage('Deploy Blue Container') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl apply -f ./kubernetes-resources/blue-replication-controller.yml
					'''
				}
			}
		}

		stage('Deploy green container') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl apply -f ./kubernetes-resources/green-replication-controller.yml
					'''
				}
			}
		}

		stage('Create Service Pointing to Blue Replication Controller') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl apply -f ./kubernetes-resources/blue-service.yml
					'''
				}
			}
		}

		stage('Approval for Redirection') {
            steps {
                input "Ready to redirect traffic to green replication controller?"
            }
        }

		stage('Create Service Pointing to Green Replication Controller') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl apply -f ./kubernetes-resources/green-service.yml
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
