pipeline {
    environment {
        USER_CREDENTIALS = credentials('dockerhub')
    }
    agent any
    

        stage('Remove Unused docker image') {
            steps {
                sh 'docker image prune'
            }
        }
        }
    }
