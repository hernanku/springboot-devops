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
                  mvn clean package -Ddockerfile.build.skip
                  """
                  junit 'target/surefire-reports/TEST-*.xml'
                  archiveArtifacts 'target/*.war'
               }
            }
         }
      }
      stage("Intergration Test"){
          steps{
             script {
               docker.image('hernanku/maven3:latest').inside('-v $HOME:/root') {
                  sh """
                  mvn clean verify 
                  """
               }
            }  
         }  
      }
      stage("Upload Artifact to Artifactory server"){
          steps{
             script {
               docker.image('hernanku/maven3:latest').inside('-v $HOME:/root') {
                  sh """
                  mvn clean deploy
                  """
               }
            }  
         }  
      }
   }
   // post {
   //    always {
   //       cleanWs()
   //    }
   // } 
}
