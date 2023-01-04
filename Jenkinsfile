pipeline{
    agent any 
    stages {   
        stage('Git Checkout'){
            steps{ 
                script{   
                   git branch: 'python-app', url: 'https://github.com/darshitsri/project1.git'
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
                    sh 'helm upgrade --install pythonapp-helm python-helm'
                    //sh 'kubectl apply -f  k8s-deployment.yaml' 
                   // sh 'kubectl apply -f  service.yaml'
                }
            }
         }
       }
     }  
