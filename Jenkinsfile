pipeline {
    environment {
        registry = "489198589229.dkr.ecr.eu-west-1.amazonaws.com/strider-docker-spark"
        dockerImage = ''
    }

    agent any

    stages {
        stage("ECR login") {
            agent any
            steps {
                sh '''
                aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 489198589229.dkr.ecr.eu-west-1.amazonaws.com/strider-docker-spark
                '''
            }
            }
        stage('Building image') {
            steps {
                sh '''
                docker build -t strider-docker-spark .
                '''
            }
        }
        stage('Push image from master') {
            when {
                branch "master"
                }
            steps {
                sh '''
                docker tag strider-docker-spark:latest 489198589229.dkr.ecr.eu-west-1.amazonaws.com/strider-docker-spark:latest
                docker push 489198589229.dkr.ecr.eu-west-1.amazonaws.com/strider-docker-spark:latest
                '''
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
