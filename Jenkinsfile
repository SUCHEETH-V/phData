pipeline {
  agent any

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    AWS_DEFAULT_REGION    = 'ap-south-1'
    SECRET_ID             = 'mysql/connection'
  }

  stages {
    stage('Checkout Code') {
      steps {
        git 'https://github.com/SUCHEETH-V/phData.git'
      }
    }

    stage('Fetch MySQL Credentials') {
      steps {
        script {
          def secretJson = sh(
            script: "aws secretsmanager get-secret-value --secret-id $SECRET_ID --query SecretString --output text",
            returnStdout: true
          ).trim()

          def creds = readJSON text: secretJson

          env.MYSQL_HOST = creds.host
          env.MYSQL_PORT = creds.port
          env.MYSQL_USER = creds.username
          env.MYSQL_PASS = creds.password
        }
      }
    }

    stage('Run Query Script') {
      steps {
        sh './query_employees.sh'
      }
    }
  }

  post {
    success {
      echo '✅ Query executed successfully.'
    }
    failure {
      echo '❌ Failed. Check logs.'
    }
  }
}
