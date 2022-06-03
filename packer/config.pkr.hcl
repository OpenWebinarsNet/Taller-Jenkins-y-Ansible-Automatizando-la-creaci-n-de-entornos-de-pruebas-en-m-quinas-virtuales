packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "jenkins-ubuntu-c-lang" {
  project_id = "just-landing-347305"
  source_image = "ubuntu-2004-focal-v20220404"
  ssh_username = "packer"
  zone = "europe-west3-b"
  image_name = "jenkins-ansible-agent"
}

build {
  sources = ["sources.googlecompute.jenkins-ubuntu-c-lang"]

  provisioner "ansible" {
    user = "packer"
    playbook_file = "./playbook.yml"
  }
}
