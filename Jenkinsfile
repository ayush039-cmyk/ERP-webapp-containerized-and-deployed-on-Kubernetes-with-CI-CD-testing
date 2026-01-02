pipeline {
    agent any

    stages {
        stage('Setup') {
            steps {
                sh '''
                cd "College-ERP"
                pip install --no-cache-dir --break-system-package -r requirements.txt
                '''
            }
        }
        stage('Run'){
            steps{
            sh '''
                cd "College-ERP"
                python3 manage.py check
                '''
            }
        }
    }
}

