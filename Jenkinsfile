pipeline{
    agent any 
    stages {   
        stage('Git Checkout'){
            steps{ 
                script{   
                   git branch: 'python-app', credentialsId: 'aws-code-commit-cred', url: 'https://git-codecommit.us-east-2.amazonaws.com/v1/repos/devops-demo-poc'
                }
            }
        }
    stage('Docker image build'){
            steps{
                script{
                    sh 'pwd'
                    sh 'ls -lrths'
                    sh 'docker image build -t python-app:$BUILD_ID .'
                    sh 'docker image tag python-app:$BUILD_ID darshitsri/python-app:latest'
                    sh 'docker push darshitsri/python-app:latest'
                }
            }
         } 
    stage ('kubernetes deployment'){     
             steps{
                script{
                    sh 'pwd'
                    sh 'kubectl get ns'
                    sh 'kubectl apply -f  k8s-deployment.yaml' 
                   // sh 'kubectl apply -f  service.yaml'
                }
            }
         }
       }
     }  
