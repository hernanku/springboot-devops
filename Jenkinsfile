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
               docker.image('hernanku/maven3:latest').inside {
                  sh """
                  mvn clean package -Dmaven.test.failure.ignore -Ddockerfile.build.skip -DskipTests 
                  """
                //   junit 'target/surefire-reports/TEST-*.xml'
               }
            }
         }
      }
      stage("Intergration Test"){
          steps{
             script {
               docker.image('hernanku/maven3:1.0.1').inside {
                  sh """
                  mvn clean verify -Dmaven.test.skip=true -Ddockerfile.build.skip -Dmaven.test.failure.ignore
                  """
               }
            }  
         }  
      }
      stage("Upload Artifact to Artifactory server"){
          steps{
             script {
               docker.image('hernanku/maven3:1.0.1').inside {
                  sh """
                  ls -altr .m2
                  mvn clean deploy -Dmaven.test.skip=true -Ddockerfile.build.skip -Dmaven.test.failure.ignore -DskipTests 
                  """
                  archiveArtifacts 'target/*.war'
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
