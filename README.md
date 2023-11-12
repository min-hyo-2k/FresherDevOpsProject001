# Deploying Django Webapp to AWS

## Project Goals:
- Deploy AWS Infrastructure using Terraform modules. :white_check_mark:
- Dockerize Django app and push it to AWS Elastic Container Registry (ECR). :white_check_mark:
- Provision EC2 Instances and pull latest Docker image and run it. :white_check_mark: (Current doing it manually. Plan to do automaticaly with Ansible and GitHub Actions)
- Create workflows for GitHub Actions (CI/CD) Pipeline. (In Progress...)
- Update the Django app's database connection from the local SQLite3 database to a MySQL RDS instance. (In Progress...)
- Provisoin EC2 Instances using Ansible. (In Progress...)
- Create task using lambda. (In Progress...)

## Project Structure
![Infrastructure](./assests/DevOpsDiagram.drawio.png)
