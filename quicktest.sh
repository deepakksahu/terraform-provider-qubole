#!/bin/bash

clear
>~/tflogfile.log
go build -o terraform-provider-qubole
terraform init
terraform plan
terraform apply