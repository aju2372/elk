#dns record creation for es,logstash & kibana
output "kibana_private_ip" {
  value = module.kibana.server_private_ip
}

output "elasticsearch_private_ip" {
  value = module.elasticsearch.server_private_ip
}

output "logstash_private_ip" {
  value = module.logstash.server_private_ip
}

#To create security group rule for 9200(on ES server), 8200(For apm on ES server) & 5601(kibana)
output "kibana_sg_id" {
  value = module.kibana.server_sg_id
}

output "elasticsearch_sg_id" {
  value = module.elasticsearch.server_sg_id
}

output "logstash_sg_id" {
  value = module.logstash.server_sg_id
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}
