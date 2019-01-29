pipeline {
    environment {
        registry = "quay.io/hellofresh/strider-docker-spark"
        registryCredential = 'strider-docker-spark'
    }

    agent any
    
    stages {
        stage('Building image') {
            steps{
                script {
                    docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
    }
}
