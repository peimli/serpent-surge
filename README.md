Serpent Surge – DevOps Final Project

This repository contains the final project for my DevOps course. The goal was to build and deploy a full-stack game application using Docker containers, hosted in a cloud environment (AWS), with infrastructure managed by Terraform and automation handled by Ansible.

The application includes automated database backups to Amazon S3, using systemd timers.
Project Overview

Key Objectives:

    Deploy a browser-based game application

    Use Terraform to provision AWS infrastructure (EC2, RDS, S3)

    Use Ansible to configure the EC2 instance and deploy Docker-based frontend/backend

    Automate database backups to S3 with rotation

    Ensure modular and repeatable infrastructure and configuration

Technologies Used

    Terraform: For provisioning AWS infrastructure

    Ansible: For server configuration and application deployment

    Docker & Docker Compose: To containerize and run the application

    AWS Free Tier: EC2 (application host), RDS (MySQL database), S3 (backups)

    Systemd: For scheduling database backups

    GitHub / GitLab: Version control

Project Structure

final-project/
├── terraform/     # AWS infrastructure (VPC, EC2, RDS, S3)
├── ansible/       # Server configuration and deployment
├── docker/        # Frontend and backend source code and Dockerfiles
├── bash/          # Database creation and backup scripts

How to Deploy
1. Clone the Repository

git clone https://github.com/peimli/linux-final-project.git
cd linux-final-project

2. Set Up AWS Credentials

Ensure you have valid AWS credentials using:

aws configure

Use an account within the AWS Free Tier limits.
3. Deploy Infrastructure and Configure Everything

Run the deployment script:

chmod +x deploy.sh
./deploy.sh

This will:

    Create AWS resources via Terraform

    Extract required IPs and credentials from outputs

    Automatically apply Ansible playbook using the Terraform outputs

Application Access

Once deployed:

    Frontend: Visit http://<EC2_PUBLIC_IP> in your browser

    Backend API:

        Get top scores: http://<EC2_PUBLIC_IP>/top-scores

        Save score: http://<EC2_PUBLIC_IP>/save-score

Replace <EC2_PUBLIC_IP> with the actual public IP output by Terraform.
Database & Backups

    Database: MySQL hosted in RDS

    Backups:

        Daily backups using systemd timer

        Stored in S3

        Only the 3 most recent backups are retained

To manually trigger a backup:

sudo systemctl start backup-score.service

To check backup timer:

systemctl status backup-score.timer

To review logs:

journalctl -u backup-score.service

To Destroy the Setup

To remove all AWS resources:

cd terraform
terraform destroy

The following parts are already completed:

- ✅ Infrastructure deployed with Terraform (EC2, RDS, S3)
- ✅ Full application setup with Ansible
- ✅ MySQL RDS integration
- ✅ Database backup script uploads to S3
- ✅ Backups automatically rotate (keeps only latest 3)
- ✅ One-click deploy script via `deploy.sh`

---

The following parts are still **in progress or missing**:

- ⬜ **CI/CD Pipeline**
  - Create `.gitlab-ci.yml`
  - Split image build into separate frontend/backend jobs
  - Add deployment job(s) to push images to EC2
  - Trigger pipeline on push to `main`

- ⬜ **Database initialization via Ansible**
  - Make sure `01-create-database.sh` runs and creates the `scores` table automatically

- ⬜ **Architecture Diagram**
  - Visual diagram showing EC2, RDS, S3, Docker containers
  - Tool recommended: [draw.io](https://draw.io)

- ⬜ **Code cleanup**
  - Refactor playbook
  - Remove unused files (e.g. older backup script)
  - Review Dockerfile size

- ⬜ **(Optional) Extra Improvements**
  - Add Elastic Load Balancer
  - Explore unknown AWS features
  - Try building a full one-click setup for entire infra

---

