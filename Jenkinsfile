pipeline {
   agent none
   parameters {
      gitParameter branchFilter: 'origin/(.*)', defaultValue: 'develop', name: 'BRANCH', type: 'PT_BRANCH'
   }
   stages {
      stage('Checkout') {
         steps {
            git branch: "${params.BRANCH}", url: "https://github.com/hernanku/springboot-devops.git"
         }
      }
      stage('Build and Test') {
         agent {
            docker {
               image 'hernanku/maven3:latest'
            }
            stages {
               stage('Build') {
                  steps {
                     sh "mvn -Dmaven.test.failure.ignore clean"
                  }
               }
               stage('Test') {
                  steps {
                     script {
                        // sh """
                        // test_container_id=\$(docker create test-container:1.0 test)
                        // docker create -a \$test_container_id
                        // docker cp "/var/www/java/target/surefire-reports" "."
                        // """

                        junit '**/target/surefire-reports/TEST-*.xml'
                        archive '**/target/*jar'
                     }
                  }
               }
               post {
                  success {
                     stash name: 'artifacts', includes: "target/**"
                  }
               }
            }
         }
      }
      // stage('Unit Test') {
      //    steps {
      //       script {
      //          sh """
      //          test_container_id=\$(docker create test-container:1.0 test)
      //          docker create -a \$test_container_id
      //          docker cp "/var/www/java/target/surefire-reports" "."
      //          """
      //          junit 'surefire-reports'
      //          archive 'target/*.jar'

      //       }

      //    }
      // }
   }
   post { 
        always { 
            cleanWs()
        }
    }
} 

      

