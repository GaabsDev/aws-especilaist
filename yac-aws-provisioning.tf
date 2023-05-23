provider "aws" {
  region = "us-west-2"  # substitua pela região desejada
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c94855ba95c71c99"  # substitua pela AMI da sua escolha
  instance_type = "t2.micro"  # substitua pelo tipo de instância desejado

  tags = {
    Name = "Web Server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"  # substitua pelo usuário desejado
    private_key = file("~/.ssh/id_rsa")  # substitua pelo caminho para sua chave privada SSH
    host        = self.public_ip
  }

  # Libera acesso HTTP na instância
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Libera acesso SSH na instância
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
