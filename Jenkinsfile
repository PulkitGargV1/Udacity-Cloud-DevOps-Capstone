pipeline {
    environment {
        USER_CREDENTIALS = credentials('dockerhub')
    }
    agent any
    
	    stage('Build Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker build -t gargpulkit/tourism_app .
					'''
				}
			}
		}

		stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push gargpulkit/tourism_app
					'''
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
						kubectl apply -f ./blue-replication-controller.yml
					'''
				}
			}
		}

		stage('Deploy green container') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl apply -f ./green-replication-controller.yml
					'''
				}
			}
		}

		stage('Create Service Pointing to Blue Replication Controller') {
			steps {
				withAWS(region:'us-east-1', credentials:'aws-user') {
					sh '''
						kubectl apply -f ./blue-service.yml
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
						kubectl apply -f ./green-service.yml
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
