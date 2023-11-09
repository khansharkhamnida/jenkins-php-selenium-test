stage('Deploy') {
    agent any
    steps {
        script {
            echo "Current user: ${sh(script: 'whoami', returnStdout: true).trim()}"
            echo "Current workspace: ${env.WORKSPACE}"

            // Set execute permissions and then run deployment script
            sh 'chmod +x ./jenkins/scripts/deploy.sh'
            sh './jenkins/scripts/deploy.sh'

            input message: 'Finished using the web site? (Click "Proceed" to continue)'

            // Set execute permissions and then run kill script
            sh 'chmod +x ./jenkins/scripts/kill.sh'
            sh './jenkins/scripts/kill.sh'
        }
    }
}
