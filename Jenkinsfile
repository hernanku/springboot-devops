pipeline {
   agent any
   parameters {
      gitParameter branchFilter: 'origin/(.*)', defaultValue: 'develop', name: 'BRANCH', type: 'PT_BRANCH'
   }
   stages {
      stage('Checkout') {
         steps {
            script {
               git branch: "${params.BRANCH}", url: "https://github.com/hernanku/springboot-devops.git"
               docker.image('hernanku/maven3:latest').inside('-v $HOME:/root') {
                  sh """
                  mvn clean package
                  pwd
                  ls -l
                  ls -ltr target
                  """
                  junit 'target/surefire-reports/TEST-*.xml'
                  archiveArtifacts 'target/*.jar'
               }
            }
         }
      }
   }
} 
