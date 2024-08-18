pipeline{
    agent any

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: true, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: true, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }
    
    environment {
        AZURE_CREDENTIALS = credentials('credentials_id')
    }
    
    stages {
        stage('Checkout From Git') {
            steps {
                git branch: 'main', url: 'https://github.com/RameshKrishnanNaraKrish/E2E-1-tire-Devops'
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([azureServicePrincipal('credentials_id')]){
                            dir('Terraform') {
                                sh 'echo "=================Terraform Plan=================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([azureServicePrincipal('credentials_id')]){
                            dir('Terraform') {
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([azureServicePrincipal('credentials_id')]){
                            dir('Terraform') {
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }

    }
}