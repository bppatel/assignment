resource "aws_security_group" "allow" {
  name        = "Elastic_Search_FW"
  description = "Allow"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
  ingress {
    from_port   = "9200"
    to_port     = "9200"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
 ingress {
    from_port   = "9300"
    to_port     = "9300"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow "
  }
}
