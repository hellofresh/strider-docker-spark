pipeline {
    environment {
        registry = "hellofresh/strider-docker-spark"
        registryCredential = 'strider-docker-spark'
    }

    agent any

    stages {
        stage('Building image') {
            steps {
                script {
                    docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push image from master') {
            when {
                branch "DWH-2595_Jenkinsfile"
            }
            steps {
                script {
                    docker.withRegistry('https://quay.io/hellofresh', registryCredential) {
                    dockerImage.push()
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
