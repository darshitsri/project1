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
                    sh 'docker image tag demo_app:$BUILD_ID darshitsri/demo_app'
                    sh 'docker push darshitsri/demo_app:latest'
                }
            }
         } 
        stage ('docker image push'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_hub1', variable: 'docker_hub_login')]) {
                        sh 'docker login -u darshitsri -p ${docker_hub_login}'
                        sh 'docker image push darshitsri/demo_app:latest'
                    }
                  }
               }
             }                  
          }
        }   
