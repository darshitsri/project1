pipeline{
   agent any
     stages{
         stage('Git TerraformCheckout'){
            steps{ 
                script{   
                   git branch: 'terraform-demo', url: 'https://github.com/darshitsri/project1.git'
                }
            }
        } 
         stage('Terraform init'){
           steps{
            dir("terraform") {
              sh 'terraform init'
                 }
              }
            }
          stage ('Terraform Apply'){
              steps{
              dir("terraform") {
                  script{
                    sh 'terraform apply --auto-approve'
                   sleep (150)
                  }
            }
            }
              }
          stage('Git Code Checkout'){
            steps{ 
                script{   
                   git branch: 'java-application', url: 'https://github.com/darshitsri/project1.git'
                }
            }
        } 
      stage('UNIT testing'){
            steps{
                script{ 
                    sh 'pwd'
                    sh 'mvn test'
                }
            }
        }
         stage('Static code analysis'){ 
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-qube-api') {  
                     //  sh 'mvn clean package sonar:sonar'
                    }
                  } 
                }
            } 
        stage('Maven build'){
            steps{
                script{ 
                    sh 'mvn clean install'
                }
            }
          }
        stage('Docker image build'){
            steps{
                script{
                    sh 'pwd'
                    sh 'ls -lrths'
                    sh 'docker image build -t java_app1:$BUILD_ID .'
                    sh 'docker image tag java_app1:$BUILD_ID darshitsri/java_app1'
                }
            }
         } 
        stage ('docker image push'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_hub1', variable: 'docker_hub_login')]) {
                        sh 'docker login -u darshitsri -p ${docker_hub_login}'
                        sh 'docker image push darshitsri/java_app1:latest'
                    }
                  }
              }
             }         stage ('Application deployment to VM'){
             steps{
                 dir("terraform") { 
                 script{                       def appDeploy = 'docker run -d -p 8085:8085 --name spring-bootapp1 darshitsri/java_app1:latest'
                     sshagent(['terraform-key']) {
                         def script_output = sh(returnStdout: true, script: """
                       #!/bin/bash
                      ip= awk 'NR==1' sample.txt
                      echo \$ip
                         """)
                      script_output = script_output.trim()
                         ip = script_output
                         echo "ip  is ${ip} running from bash"
                    // def  ip = readFile 'sample.txt'
                     def ip_addr = "${ip}"
                    // def ip_addr = "65.0.5.231"
                     def user = 'ubuntu'
                     echo "The public ip in stage App deploy ip_addr  ${ip_addr}"
                     sh "ssh   -o StrictHostKeyChecking=no ubuntu@${ip_addr} ${appDeploy}"
                     }
                 } 
              }
            }
        }
     }
}
