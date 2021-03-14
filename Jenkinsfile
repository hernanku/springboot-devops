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
      stage('Unit Test') {
         steps {
            script {
               sh """
               test_container_id=\$(docker create test-container:1.0 test)
               docker start -a \$test_container_id
               docker cp "\$test_container_id:${workdir}" "."
               """
               junit '**/target/surefire-reports/TEST-*.xml'
               archive 'target/*.jar'

            }

         }
      }
   }
   post { 
        always { 
            cleanWs()
        }
    }
} 

      

