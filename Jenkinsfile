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
                sh 'sudo ./upload_docker.sh $USER_CREDENTIALS_USR $USER_CREDENTIALS_PSW'
            }
        }
        }
    }
