pipeline{
    agent any 
    stages {   
        stage('Git Checkout'){
            steps{ 
                script{   
                   git branch: 'project-helm', url: 'https://github.com/darshitsri/project1.git'
                }
            }
        }
        stage ('Dependency check'){
            steps{
             //   dependencyCheck additionalArguments: 'scan = "/var/lib/jenkins/workspace/${JOB_NAME}" --format ALL', odcInstallation: 'OWASP-Dependency-Check'
            //dependencyCheckPublisher pattern: '**/dependency-check-report.xml', unstableNewCritical: 1, unstableNewHigh: 2, unstableTotalCritical: 1, unstableTotalHigh: 2
              dependencyCheck additionalArguments: '--scan /var/lib/jenkins/workspace/${JOB_NAME} --format ALL --disableYarnAudit', odcInstallation: 'OWASP-Dependency-Check' 
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml', unstableNewCritical: 90, unstableNewHigh: 90, unstableTotalCritical: 90, unstableTotalHigh: 90 
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
                     //  sh 'mvn clean package sonar:sonar'
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
                    sh 'docker image build -t java_app:$BUILD_ID .'
                    sh 'docker image tag java_app:$BUILD_ID darshitsri/java_app:latest'
                    //sh 'docker push darshitsri/java_app:latest'
                }
            }
         } 
        stage ('docker image push'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_hub1', variable: 'docker_hub_login')]) {
                        sh 'docker login -u darshitsri -p ${docker_hub_login}'
                        sh 'docker image push darshitsri/java_app:latest'
                    }
                  }
               }
             } 
        stage ('kubernetes deployment'){
            steps{
                script{
                    sh 'pwd'
                    sh 'kubectl get ns'
                    sh 'helm upgrade --install java-helm demo-helm'
                    // sh 'kubectl apply -f  k8sdeployment.yaml' 
                   // sh 'kubectl apply -f  service.yaml'
                }
            }
         }
       }
     }   
