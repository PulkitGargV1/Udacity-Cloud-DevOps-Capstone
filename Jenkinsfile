pipeline {
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
			sh 'hadolint ./Dockerfile'
		}
	}
		

	}
}
