pipeline {
    agent none

    stages {
        stage('Integration UI Test') {
            parallel {
                stage('Deploy') {
                    agent any
                    steps {
                        script {
                            echo "Current user: ${sh(script: 'whoami', returnStdout: true).trim()}"
                            echo "Current workspace: ${env.WORKSPACE}"

                            // Run deployment script and set execute permissions
                            sh '''
                                ./jenkins/scripts/deploy.sh
                                chmod +x ./jenkins/scripts/deploy.sh
                                ./jenkins/scripts/kill.sh
                                chmod +x ./jenkins/scripts/kill.sh
                            '''
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
                        script {
                            // Specify a user with sufficient permissions inside the Docker container
                            sh 'mvn -B -DskipTests clean package'
                            sh 'mvn test'
                        }
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
