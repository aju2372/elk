#!/bin/bash
sudo apt-get update -y
sudo apt-get install openjdk-11-jdk apt-transport-https wget nginx -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update -y
sudo apt-get install elasticsearch -y
sudo mv /root/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo chown elasticsearch:elasticsearch /etc/elasticsearch/elasticsearch.yml

sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch

sleep 5

curl -L -O https://artifacts.elastic.co/downloads/logstash/logstash-7.0.0.deb
sudo dpkg -i logstash-7.0.0.deb
# sudo mv 30-output.conf /etc/logstash/conf.d/30-output.conf
# sudo mv 12-json.conf /etc/logstash/conf.d/12-json.conf
# sudo mv 02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf

sudo systemctl start logstash
sudo systemctl enable logstash

sleep 5

sudo apt-get install kibana -y
sudo mv /root/kibana.yml /etc/kibana/kibana.yml
sudo chown kibana:kibana /etc/kibana/kibana.yml

sudo systemctl start kibana
sudo systemctl enable kibana

sleep 5

echo "admin:`openssl passwd -apr1 kibanaadmin`" | sudo tee -a /etc/nginx/htpasswd.kibana
sudo mv /root/kibana /etc/nginx/sites-available/kibana

sudo ln -s /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/kibana
sudo nginx -t

sudo systemctl start nginx
sudo systemctl enable nginx
sudo ufw allow 'Nginx Full'

sleep 5

sudo systemctl restart nginx
sudo systemctl restart kibana
