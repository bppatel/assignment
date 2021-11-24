
/*resource "aws_instance" "myInstanceAWS" {
  for_each      = toset(var.subnet_ids)
  ami           = var.image_id
  instance_type = var.instance_type
  //  count         = length(var.subnet_ids)
  //  subnet_id     = var.subnet_ids[count.index]
  subnet_id = each.key
  tags = {
    //    Name = "Brijeshtest00${count.index+1}"
    Name = "brijesh${each.key}"
  }
}*/

resource "aws_instance" "myInstanceAWS" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${var.ami_id}"
  key_name      = "${var.ssh_key_name}"
  subnet_id     = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.allow.id}"]
  tags = {
    Name = "${var.instance_name}${count.index + 1}"

  }
}

resource "null_resource" "ConfigureAnsibleLabelVariable" {
  provisioner "local-exec" {
    command = "echo [${var.dev_host_label}:vars] > hosts"
  }
  provisioner "local-exec" {
    command = "echo ansible_ssh_user=${var.ssh_user_name} >> hosts"
  }
  provisioner "local-exec" {
    command = "echo ansible_ssh_private_key_file=${var.ssh_key_path} >> hosts"
  }
  provisioner "local-exec" {
    command = "echo [${var.dev_host_label}] >> hosts"
  }
}
resource "null_resource" "ProvisionRemoteHostsIpToAnsibleHosts" {
  count = "${var.instance_count}"
  connection {
    type        = "ssh"
    user        = "${var.ssh_user_name}"
    host        = "${element(aws_instance.myInstanceAWS.*.public_ip, count.index)}"
    private_key = "${file("${var.ssh_key_path}")}"
  }
  provisioner "remote-exec" {
    inline = [
      //      "sudo yum update -y",
      "sudo yum install git -y",
      "sudo yum --enablerepo=extras install epel-release -y",
      "sudo yum install python-setuptools python-pip -y",
      "sudo pip install httplib2"
    ]
  }
  provisioner "local-exec" {
    command = "echo ${element(aws_instance.myInstanceAWS.*.public_ip, count.index)} >> hosts"
  }
}
resource "null_resource" "ModifyApplyAnsiblePlayBook" {
  provisioner "local-exec" {
    command = "sed -i -e '/hosts:/ s/: .*/: ${var.dev_host_label}/' play01.yaml" #change host label in playbook dynamically
  }

  provisioner "local-exec" {
    command = "sleep 11; ansible-playbook -i hosts play01.yaml"
  }
  depends_on = ["null_resource.ProvisionRemoteHostsIpToAnsibleHosts"]
}

