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
            steps {
                sh '$(aws2 ecr get-login --no-include-email --region eu-west-1 --registry-ids 489198589229 --registry-ids 489198589229)'
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
