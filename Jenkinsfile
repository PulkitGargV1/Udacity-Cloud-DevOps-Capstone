pipeline {
	environment {
        USER_CREDENTIALS = credentials('dockerhub')
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
                sh './upload_docker.sh $CREDENTIALS_USR $CREDENTIALS_PSW'
            }
        }
		
	}
	
}
