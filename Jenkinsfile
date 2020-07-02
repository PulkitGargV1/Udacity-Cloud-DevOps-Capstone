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
