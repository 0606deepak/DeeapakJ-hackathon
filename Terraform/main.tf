
resource "aws_ecs_cluster" "ecscluster" {
  name = "ECS-Fargate-Cluster"
}

resource "aws_ecs_task_definition" "ecstask" {
  family                   = "ecstask"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"  
  memory                  = "512"  
container_definitions = jsonencode([{
    name      = "nodejs-app"
    image     = "patientapp:latest"  
    memory    = 3072
    cpu       = 1024
    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]
  }])

  execution_role_arn = aws_iam_role.ecstaskexecutionrole.arn
}
  

  resource "aws_ecs_service" "ecsservice" {
  name            = "ecs-fargate-service"
  cluster         = aws_ecs_cluster.ecscluster.id
  task_definition = aws_ecs_task_definition.ecstask
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.ecssubnet1.id, aws_subnet.ecssubnet2.id]
    security_groups  = [aws_security_group.ecssg.id]
    assign_public_ip = true  
  }
}

resource "aws_ecr_repository" "myrepository" {
  name                 = "nodejs-app" 
  image_tag_mutability = "MUTABLE" 
  
  tags = {
    Name = "MyAppRepo"
    Environment = "dev"
  }
}