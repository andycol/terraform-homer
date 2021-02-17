terraform {
  required_providers {
    aws = {     
	version = "~> 2.70"
	      source  = "hashicorp/aws"
   	}
   }
}
provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_instance" "web" {

  ami           = ""
  instance_type = "t2.micro"
  provisioner "file" {
  source 	= "files/homer_installer.sh"
  destination	= "/tmp/homer_installer.sh" 
  }

provisioner "remote-exec" {
	inline = [
		"chmod -x /tmp/homer_installer.sh",
		"sudo /tmp/homer_installer.sh",
	]
}

 connection {
    type        = "ssh"
    user        = "admin"
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }
}
