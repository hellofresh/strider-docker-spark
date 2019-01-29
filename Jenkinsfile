pipeline {
    environment {
        registry = "quay.io/hellofresh/strider-docker-spark"
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
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
