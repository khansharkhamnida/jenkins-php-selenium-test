pipeline {
 agent none
 stages {
  stage('Integration UI Test') {
   parallel {
    stage('Deploy') {
     agent any
     steps {
      sh "chmod +x -R ${env.WORKSPACE}"
      sh './jenkins/scripts/deploy.sh'
      input message: 'Finished using the web site? (Click "Proceed" to continue)'
      sh './jenkins/scripts/kill.sh'
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
        // Make this stage dependent on the 'Deploy' stage completion
        if (currentBuild.resultIsBetterOrEqualTo('SUCCESS')) {
          sh 'mvn -B -DskipTests clean package'
          sh 'mvn test'
        } else {
          echo 'Skipping Headless Browser Test due to failure in Deploy stage.'
        }
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
