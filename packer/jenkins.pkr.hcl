variables {
  source_ami = ""
  subnet_id  = ""
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "jenkins" {
  ami_name      = "jenkins"
  instance_type = "t2.micro"
  region        = "ap-northeast-1"
  source_ami    = "${var.source_ami}"
  subnet_id     = "${var.subnet_id}"
  ssh_username  = "ec2-user"
}

build {
  name = "jenkins"
  sources = [
    "source.amazon-ebs.jenkins"
  ]
  provisioner "ansible" {
    playbook_file = "../ansible/site.yml"
    extra_arguments = [
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}