pipeline {
   agent any
   parameters {
      gitParameter branchFilter: 'origin/(.*)', defaultValue: 'develop', name: 'BRANCH', type: 'PT_BRANCH'
   }
   stages {
      stage('Checkout') {
         steps {
            git branch: '${params.BRANCH}', url: "https://github.com/hernanku/store-webapp-sample.git"
         }
      }
      stage('Build') {
         agent {
            docker {
               image 'maven3:0.2.1'
            }
         }
         steps {
            sh "mvn -Dmaven.test.failure.ignore clean package"
         }
      }
   }
} 

      

