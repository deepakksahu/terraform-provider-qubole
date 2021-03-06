provider "qubole" {
  auth_token	=	"${var.auth_token}"
  api_endpoint	=	"${var.api_endpoint}"
}

resource "qubole_cluster" "qubole_presto_test_cluster" {
label 							=	["terraform-provider-qubole", "terraform-managed-presto"]
presto_version 					=	"0.180"
ec2_settings					=	[
										{
										aws_region						=	"ap-southeast-1"
										aws_preferred_availability_zone	=	"Any"
										vpc_id							=	"vpc-0e2be045e5fe137cd"
										subnet_id						=	"subnet-05cf662ed46f9cde8"
										bastion_node_public_dns			=	"13.229.7.25"
										bastion_node_port				=	 22
										bastion_node_user				=	"ec2-user"
										use_account_compute_creds		=	false
										}
									]
node_configuration				=	[
										{
										master_instance_type			=	"m4.xlarge"
										slave_instance_type				=	"m4.xlarge"
										initial_nodes					=	1
										max_nodes						=	3
										spot_instance_settings			=	[
																				{
																				maximum_bid_price_percentage	=	60
																				timeout_for_request	=	10
																				maximum_spot_instance_percentage	=	50
																				}
																			]
										fallback_to_ondemand			=	 true
										ebs_volume_type					=	"standard"
										ebs_volume_size					=	100
										ebs_volume_count				=	1
										custom_ec2_tags					=	{
																			"Owner"			=	"Vihag Gupta"
																			"Environment"	=	"Dev"
																			"Project"		=	"Terraform Provider"
																			}
										idle_cluster_timeout_in_secs	=	3600
										node_base_cooldown_period		=	10
										}
									]
hadoop_settings					=	[
										{
										use_hadoop2						=	true
										use_spark						=	false
										}
									]
security_settings				=	[
										{
										persistent_security_group		=	"persistent-security-group"
										}
									]
presto_settings					=	[
										{
										enable_presto					=	true
										custom_config					=	"config.properties:\nascm.enabled=true\ncatalog/hive.properties:\nhive.parquet.use-column-names=true\nbootstrap-file-path:\ns3://vihagg.us/qubole/us/scripts/hadoop/node_bootstrap_uber_hudi_presto.sh"
										}
									]
datadog_settings				=	[
										{
										datadog_api_token				=	"api-token"
										datadog_app_token				=	"app-token"
										}
									]
disallow_cluster_termination 	=	"true"
enable_ganglia_monitoring 		=	"true"
node_bootstrap_file 			=	"hoodie-presto-bootstrap.sh"
idle_cluster_timeout 			=	"1"
}
