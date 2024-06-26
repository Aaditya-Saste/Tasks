pipeline {
    agent {label "pipeline" }
    stages{
        stage("install apache") {
            steps{
                sh '''
                sudo apt update 
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo apt install unzip -y
                '''
            }
        }
        stage("download tomcat and unzip") {
            steps{
                sh '''
                sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.86/bin/apache-tomcat-9.0.86.tar.gz
                sudo tar -xzvf apache-tomcat-9.0.86.tar.gz
                '''
            }
        }
        stage("git repo cloning") {
            steps{
                sh '''
                git clone https://github.com/Aaditya-Saste/practice-repo.git
                '''
            }
        }
        stage("move student.war file") {
            steps{
                sh '''
                sudo mv /home/ubuntu/workspace/tomcat/practice-repo/student.war /home/ubuntu/workspace/tomcat/apache-tomcat-9.0.86/webapps/
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