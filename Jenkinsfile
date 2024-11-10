pipeline {
    agent any
    environment {
        // Set the path to the GCP Service Account key stored in Jenkins credentials
        GOOGLE_APPLICATION_CREDENTIALS = credentials('bits-jenkins-sa-key')  // Jenkins credential ID
    }
    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from the repository (where your Terraform files are stored)
                git 'https://github.com/Sawan-Nandi/BITS-voting-tf-gke.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform (use the existing GCS bucket for state)
                    sh 'terraform init -backend-config="bucket=${params.GCS_BUCKET}"'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Run terraform plan with the specified variables file
                    sh 'terraform plan -var-file="terraform.tfvars -var "gcp_credentials_file=${GOOGLE_APPLICATION_CREDENTIALS}"'
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    // Wait for manual approval before applying the changes
                    input message: 'Approve Terraform Plan?', ok: 'Apply'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform configuration to create the GKE cluster
                    sh 'terraform apply -var-file="terraform.tfvars" -var "gcp_credentials_file=${GOOGLE_APPLICATION_CREDENTIALS} -auto-approve'
                }
            }
        }

        stage('Output GKE Cluster Info') {
            steps {
                script {
                    // Output the GKE Cluster details like cluster name, endpoint, and certificate
                    sh 'terraform output'
                }
            }
        }
    }
    post {
        always {
            // Clean up and perform any necessary tasks after the pipeline runs
            echo 'Pipeline complete.'
        }
    }
}
