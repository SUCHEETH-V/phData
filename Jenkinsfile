pipeline {
    agent any

    environment {
        MYSQL_SECRET_ID = 'mysql-secrets'
        REGION = 'ap-south-1'
        MYSQL_HOST = '3.109.56.148'
        MYSQL_PORT = '3307'
    }

    stages {
        stage('Fetch Secrets') {
            steps {
                script {
                    def secret = sh(
                        script: "aws secretsmanager get-secret-value --region $REGION --secret-id $MYSQL_SECRET_ID --query SecretString --output text",
                        returnStdout: true
                    ).trim()
                    def json = readJSON text: secret
                    env.DB_USER = json.username
                    env.DB_PASS = json.password
                }
            }
        }

        stage('Run Script') {
            steps {
                sh """
                    chmod +x query_employees.sh
                    ./query_employees.sh $DB_USER $DB_PASS $MYSQL_HOST $MYSQL_PORT
                """
            }
        }
    }
}

