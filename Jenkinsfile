pipeline{
    agent any 
    stages {   
        stage('Git Checkout'){
            steps{ 
                script{   
                   git branch: 'main', url: 'https://github.com/darshitsri/project1.git'
                }
            }
        }
        stage('UNIT testing'){
            steps{
                script{ 
                    sh 'mvn test'
                }
            }
        }
         stage('Static code analysis'){ 
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-qube-api') {  
                        sh 'mvn clean package sonar:sonar'
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
                    sh 'docker image build -t demo_app:$BUILD_ID .'
                    sh 'docker image tag demo_app:$BUILD_ID dockerhub/demo_app'
                    sh 'docker push dockerhub/demo_app:latest'
                }
            }
         }  
       }
     }   
