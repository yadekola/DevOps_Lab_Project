pipeline {
    agent any

    tools {
        maven 'MAVEN3.9'
        jdk 'JDK17'
    }

    environment {
        registryCredential = 'ecr:us-east-1:awscreds'
        imageName = '715472013034.dkr.ecr.us-east-1.amazonaws.com/vprofileappimg'
        vprofileRegistry = 'https://715472013034.dkr.ecr.us-east-1.amazonaws.com'
    }

    stages {

        stage('Fetch Code') {
            steps {
                git branch: 'docker',
                    url: 'https://github.com/hkhcoder/vprofile-project.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }

            post {
                success {
                    echo 'Now Archiving it...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('Sonar Code Analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonar8.0'

                    withSonarQubeEnv('sonarserver') {
                        sh """
                            ${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=vprofile \
                            -Dsonar.projectName=vprofile \
                            -Dsonar.projectVersion=1.0 \
                            -Dsonar.sources=src \
                            -Dsonar.java.binaries=target/classes \
                            -Dsonar.junit.reportPaths=target/surefire-reports \
                            -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml \
                            -Dsonar.checkstyle.reportPaths=target/checkstyle-result.xml
                        """
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build App Image') {
            steps {
                script {
                    dockerImage = docker.build(
                        "${imageName}:${BUILD_NUMBER}",
                        "./Docker-files/app/multistage/"
                    )
                }
            }
        }

        stage('Upload App Image') {
            steps {
                script {
                    docker.withRegistry(
                        vprofileRegistry,
                        registryCredential
                    ) {
                        dockerImage.push("${BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Remove Container Image') {
            steps {
                sh """
                    docker rmi -f ${imageName}:${BUILD_NUMBER} || true
                """
            }
        }
    }
}