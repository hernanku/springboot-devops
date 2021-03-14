pipeline {
   agent any
   parameters {
      gitParameter branchFilter: 'origin/(.*)', defaultValue: 'develop', name: 'BRANCH', type: 'PT_BRANCH'
   }
   stages {
      stage('Checkout') {
         steps {
            git branch: "${params.BRANCH}", url: "https://github.com/hernanku/springboot-devops.git"
         }
      }
      stage('Build') {
         agent {
            docker {
               image 'hernanku/maven3:latest'
            }
         }
         steps {
            sh "mvn -Dmaven.test.failure.ignore clean"
         }
      }
   }
   post { 
        always { 
            cleanWs()
        }
    }
} 

      

