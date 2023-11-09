pipeline {
    agent none
    stages {
        stage('Integration UI Test') {
            parallel {
                stage('Deploy') {
                    agent any
                    steps {
                        script {
                            // Stop and remove existing container
                            sh 'docker stop my-apache-php-app || true'
                            sh 'docker rm my-apache-php-app || true'

                            // Set permissions for deploy.sh
                            sh 'chmod +x ./jenkins/scripts/deploy.sh'

                            // Run deploy.sh
                            sh './jenkins/scripts/deploy.sh'

                            // Wait for user input
                            input message: 'Finished using the web site? (Click "Proceed" to continue)'

                            // Set permissions for kill.sh
                            sh 'chmod +x ./jenkins/scripts/kill.sh'

                            // Run kill.sh
                            sh './jenkins/scripts/kill.sh'
                        }
                    }
                }
                stage('Headless Browser Test') {
                    agent {
                        docker {
                            image 'maven:3-alpine' 
                            args '-v /root/.m2:/root/.m2' 
                        }
                    }
                    steps {
                        sh 'mvn -B -DskipTests clean package'
                        sh 'mvn test'
                    }
                    post {
                        always {
                            junit 'target/surefire-reports/*.xml'
                        }
                    }
                }
            }
        }
    }
}
