pipeline {
    agent any

    tools {
        maven 'M3'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/BurbaJolof/demo-boot.git'
            }
        }
     stage('Cleaning Workspace') {
            steps {
                sh 'mvn clean'

                script {
                    try {
                        sh 'docker rmi demo-boot' 
                   } catch (Exception e) {
                        echo 'No Container to remove'
                  }
                }
            }
        }
        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('Test Unitaire') {
            steps {
                sh 'mvn test'
            }
            
            post {
                success {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }
        stage('Build Docker image') {
            steps {
                echo "-=- Building Docker image"
                sh 'docker build -t demo-boot .'
            }
        }
        stage('Deploy to test') {
            steps {
                echo "-=- Deploy to test en in EC2"
                sh 'docker run --name demo-boot -p 8180:8080 demo-boot'
            }
        }
    }
}
