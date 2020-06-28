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
        stage('Deploy image to EKS cluster') {
            steps {
                withAWS(region:'us-east-1', credentials:'aws-user') {
                sh '''aws --region us-east-1 eks update-kubeconfig --name TourismappEKS'''
	            sh '''kubectl get nodes'''
                //For the first deployment, uncomment the below command
              sh '''kubectl run tourismapideployment --image=gargpulkit/tourism_app:"$BUILD_ID" --port=8080 --expose=true'''
              sh '''kubectl set image deployments/tourismapideployment tourismapideployment=gargpulkit/tourism_app:"$BUILD_ID"'''
	          sh '''kubectl rollout status -w deployment/tourismapideployment'''
	          sh '''kubectl scale deployments/tourismapideployment --replicas=3'''
	          sh '''kubectl get pods -o wide'''
	          sh '''kubectl describe deployment tourismapideployment'''
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
