pipeline {
    agent any

    // Load shared library
    libraries {
        lib('your-shared-library-name') // Replace with your actual shared library name
    }

    environment {
        DOCKER_REGISTRY = 'your-docker-registry.com'
        IMAGE_NAME = 'your-image-name'
        IMAGE_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'docker-creds-id' // Jenkins credentials ID for Docker login
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-org/your-repo.git', branch: 'main'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", "${DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
