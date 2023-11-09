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

                            // Manually change permissions
                            sh "chmod +x ${env.WORKSPACE}/jenkins/scripts/deploy.sh"
                            sh "chmod +x ${env.WORKSPACE}/jenkins/scripts/kill.sh"

                            // Debugging information
                            echo "Permissions after manual chmod:"
                            sh "ls -lR ${env.WORKSPACE}/jenkins/scripts"

                            sh './jenkins/scripts/deploy.sh'
                            input message: 'Finished using the web site? (Click "Proceed" to continue)'
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
