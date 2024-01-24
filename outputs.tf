output "elastic_ip" {
  value       = module.jenkins_server.*.public_ip
  description = "The elastic IP of the EC2 Jenkins server"
}