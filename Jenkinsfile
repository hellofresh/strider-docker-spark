pipeline {
    environment {
        registry = "hellofresh/strider-docker-spark"
        registryCredential = 'strider-docker-spark'
        dockerImage = ''
    }

    agent any

    stages {
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push image from master') {
            when {
                branch "master"
            }
            steps {
                script {
                    docker.withRegistry('https://quay.io', registryCredential) {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
    post {
        always {
            sh "docker rmi $registry:$BUILD_NUMBER"
        }
    }
}
