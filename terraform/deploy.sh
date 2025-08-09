#!/bin/bash

set -e

echo "🧱 Running Terraform..."
cd terraform
terraform init -upgrade
terraform apply -auto-approve

echo "📦 Exporting Terraform outputs..."
terraform output -json > ../ansible/terraform-outputs.json

# Extract EC2 IP for inventory
EC2_IP=$(terraform output -raw ec2_public_ip)
cd ../ansible

echo "📝 Generating Ansible inventory..."
cat > inventory.ini <<EOF
[web]
$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=../terraform/serpent-surge-key.pem
EOF

echo "🤖 Running Ansible playbook..."
sudo ansible-playbook -i inventory.ini -e "@terraform-outputs.json" playbook.yml

echo "✅ Deployment complete!"
