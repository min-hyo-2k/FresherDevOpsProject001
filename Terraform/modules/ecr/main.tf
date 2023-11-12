resource "aws_ecr_repository" "django_app" {
  name = "my-django-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "default_policy" {
  repository = aws_ecr_repository.django_app.name
	

	  policy = <<EOF
	{
	    "rules": [
	        {
	            "rulePriority": 1,
	            "description": "Keep only the last ${var.untagged_images} untagged images.",
	            "selection": {
	                "tagStatus": "untagged",
	                "countType": "imageCountMoreThan",
	                "countNumber": ${var.untagged_images}
	            },
	            "action": {
	                "type": "expire"
	            }
	        }
	    ]
	}
	EOF
	

}

# build and push docker image from local to ECR
data "aws_caller_identity" "current" {}

resource "null_resource" "docker_packaging" {
	
	  provisioner "local-exec" {
	    command = <<EOF
        cd ${var.local_docker_path}
	    aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-southeast-1.amazonaws.com
        docker build -t "${aws_ecr_repository.django_app.repository_url}:latest" -f Dockerfile .
	    docker push "${aws_ecr_repository.django_app.repository_url}:latest"
	    EOF
	  }
	

	  triggers = {
	    "run_at" = timestamp()
	  }
	

	  depends_on = [
	    aws_ecr_repository.django_app,
	  ]
}