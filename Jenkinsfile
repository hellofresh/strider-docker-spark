pipeline {
    environment {
        registry = "489198589229.dkr.ecr.eu-west-1.amazonaws.com/strider-docker-spark"
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
                sh '$(aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 489198589229.dkr.ecr.eu-west-1.amazonaws.com)'
                script {
                    docker.withRegistry('https://489198589229.dkr.ecr.eu-west-1.amazonaws.com') {
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
