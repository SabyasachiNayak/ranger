project = "sa-demo-project-1"
region = "us-central1"
zone = "us-central1-a"

vpc_network = "sabs-vpc"
subnet = "sabs-subnet1"
#your local ip
local_ips = ["98.180.206.139"] 
firewall_name = "ranger"
target_tags = ["ranger"]

#mysql
db_instance_identifier = "sabs-ranger-db"
db_version = "MYSQL_5_7"
db_instance_type = "db-f1-micro"
db_disk_type = ""
db_disk_size = ""
db_name = "ranger"

#database root user
db_user = "root"
db_pwd = "password"
db_ranger_user = "rangeradmin"
db_ranger_pwd = "password"

ranger_admin_name = "terraform-ranger-admin"
machine_type = "g1-small"
image = "centos-7-v20190916"
instance_tags = ["http-server","ranger"]

ranger_solr_name = "terraform-ranger-solr"
solr_machine_type = "g1-small"

health_check_name = "ranger-health-check"
instance_template_name = "ranger-instance-template"
managed_group_name = "ranger-managed-group"
auto_scaler_name = "ranger-autoscaler"
min_replicas = 1
max_replicas = 2
unmanaged_group_name = "ranger-unmanaged-group"

#load balancer
lb_firewall_name = "allow-ranger-lb"
lb_name = "ranger-lb"
lb_backend_name = "ranger-lb-backend"
lb_frontend_name = "ranger-lb-frontend"
target_proxy = "ranger-target-proxy"
max_request_rate = 5

#cookie duration in seconds
cookie_duration = 86400

#port
ranger_port = 6080
solr_port = 6083
ssh_port = 22

solr_download_url = "http://archive.apache.org/dist/lucene/solr/7.0.0/solr-7.0.0.tgz"