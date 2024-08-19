pipeline{
    agent any

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: true, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: true, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }
    
    environment {
        AZURE_CREDENTIALS = credentials('credentials_id')
        GITHUB_TOKEN = credentials('github_token') 
    }
    
    stages {
        stage('Checkout From Git') {
            steps {
                git branch: 'main', url: 'https://github.com/RameshKrishnanNaraKrish/azure-AppService-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([azureServicePrincipal('credentials_id')]){
                            dir('Terraform') {
                                sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                                sh 'echo "=================Terraform init=================="'
                                sh 'terraform init'
                            }
                        }
                    }
                }
            }
        }

        
        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([azureServicePrincipal('credentials_id')]){
                            dir('Terraform') {
                                //sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
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
                                //sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                                //sh 'terraform apply -var "github_token=${GITHUB_TOKEN}" --auto-approve'
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply --auto-approve'
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
                                //sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy --auto-approve'
                            }
                        }
                    }
                }
            }
        }

    }
}