pipeline {
    agent {label "student"}
    stages {
        stage("cloning repo") {
            steps {
                sh '''
                git clone https://github.com/Aaditya-Saste/studentapp-ui.git
                '''
            }
        }
        stage("Install Apache") {
            steps {
                sh '''
                sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.86/bin/apache-tomcat-9.0.86.tar.gz
                sudo tar -xzvf apache-tomcat-9.0.86.tar.gz
                '''
            }
        }
        stage("Install Maven") {
            steps {
                sh  '''
                sudo apt update
                sudo apt install maven -y
                '''
            }
        }
        stage("Build Artifact") {
            steps {
                sh  '''
                sudo chown -R ubuntu:ubuntu /home/ubuntu/*
                cd /home/ubuntu/workspace/tomcat/studentapp-ui
                sudo mvn clean
                sudo mvn package
                '''
            }
        }
        stage("move war file in apache") {
            steps {
                sh '''
                sudo mv /home/ubuntu/workspace/tomcat/studentapp-ui/target/studentapp-2.2-SNAPSHOT.war /home/ubuntu/workspace/tomcat/apache-tomcat-9.0.86/webapps/student.war
                '''
            }
        }
        stage("starting catalina file") {
            steps{
                sh '''
                sudo bash /home/ubuntu/workspace/tomcat/apache-tomcat-9.0.86/bin/catalina.sh stop
                sudo bash /home/ubuntu/workspace/tomcat/apache-tomcat-9.0.86/bin/catalina.sh start
                '''
            }
        }
    }
}