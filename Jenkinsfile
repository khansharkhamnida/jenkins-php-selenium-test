pipeline {
    agent none
    stages {
        stage('Integration UI Test') {
            parallel {
                stage('Deploy') {
                    agent any
                    steps {
                        script {
                            // Add debugging information
                            echo "Current user: ${sh(script: 'whoami', returnStdout: true).trim()}"
                            echo "Current workspace: ${env.WORKSPACE}"
                            echo "Permissions before chmod:"
                            sh "ls -lR ${env.WORKSPACE}/jenkins/scripts"

                            // Uncomment the next line to apply chmod recursively
                            // sh "chmod +x -R ${env.WORKSPACE}"
                            
                            // Add more debugging information after chmod
                            echo "Permissions after chmod:"
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
