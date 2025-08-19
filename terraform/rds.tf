resource "aws_db_subnet_group" "default" {
  name = "serpent-db-subnet-group"
  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

resource "aws_db_instance" "mysql" {
  identifier                 = "serpent-db"
  engine                     = "mysql"
  engine_version             = "8.0"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  db_name                    = "serpent_surge_db"
  username                   = "admin"
  password                   = var.db_password
  skip_final_snapshot        = true
  publicly_accessible        = true
  db_subnet_group_name       = aws_db_subnet_group.default.name
  vpc_security_group_ids     = [aws_security_group.rds.id]
  deletion_protection        = false
  auto_minor_version_upgrade = true
  tags = {
    Name = "serpent-db"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project}-rds-sg"
  description = "RDS only allows MySQL from EC2 SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.main.id]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Project = var.project }
}
