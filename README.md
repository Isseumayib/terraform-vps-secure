# Terraform VPS Sécurisé sur AWS

Ce projet contient une infrastructure codée en Terraform permettant de déployer un serveur privé virtuel (VPS) sécurisé sur AWS, en respectant les bonnes pratiques de sécurité recommandées par les **CIS Benchmarks**.

##  Objectifs

- Déploiement d’un VPS (EC2) dans AWS.
- Configuration sécurisée (ports limités, accès SSH par clé uniquement, etc.).
- Surveillance avec CloudWatch.
- Traçabilité avec AWS CloudTrail.
- Analyse de sécurité avec AWS GuardDuty.
- Conformité via AWS Config.

## Technologies utilisées

- Terraform
- AWS EC2, IAM, VPC, CloudWatch, CloudTrail, GuardDuty, AWS Config
- SSH (authentification par clé)
- CIS Benchmarks (niveau 1)

##  Structure du projet

```bash
.
terraform-vps-secure/
├── main.tf
├── variables.tf
├── outputs.tf
├── vpc.tf
├── security.tf
├── ec2.tf
├── cloudtrail.tf
├── cloudwatch.tf
├── guardduty_config.tf
├── terraform.tfvars

