pipeline{
    
    agent any 
    tools {
        maven 'maven 3.2.5'
    }
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
    } 
}
