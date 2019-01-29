
def call(body) {
    // evaluate the body block, and collect configuration into the object
    def pipelineParams= [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = pipelineParams
    body()

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
}
