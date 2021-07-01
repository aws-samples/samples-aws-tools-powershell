#region LIST SUBNET IDS AND AVAILABLE ZONES ###################################
Get-EC2Subnet | select SubnetId, AvailabilityZone

<#
SubnetId                  AvailabilityZone
--------                  ----------------
subnet-0082e4e453f3dd53c  us-east-1e
subnet-0082e4e453f3dd53c  us-east-1f
subnet-0082e4e453f3dd53c  us-east-1c
#>
#endregion

#region LIST INSTANCE ID AND STATUS ###########################################
Get-EC2InstanceStatus | select InstanceId, { $_.InstanceState.Name }

<#
InstanceId          $_.InstanceState.Name
----------          ---------------------
i-bfff2bca9f72c45b2 running
i-1fe8e4c8557a31c31 running
i-3cb6084277d591e08 running
i-575c70e0e9c9c6423 running
i-0002f0c0de939d4d2 running
...
#>
#endregion

#region LIST INSTANCE ID AND PRIVATE IP      ###################################
Get-EC2Instance | select -ExpandProperty Instances | select InstanceId, PrivateIPAddress

<#
InstanceId          PrivateIpAddress
----------          ----------------
i-f489752eb7d9194da 10.0.1.13
i-6d711dc6f40776244 10.0.7.37
i-7c276cd13dda7db2d 10.0.7.28
i-7357456b837a804df 10.0.7.112
#>
#endregion

#region LIST ELASTIC IP ADDRESSES      #########################################
Get-EC2Address | select PrivateIpAddress, PublicIp

<#
PrivateIpAddress PublicIp
---------------- --------
10.0.1.2 12      34.226.14.122
10.97.19.67      3.238.212.67
10.96.154.161    34.226.14.23
10.97.7.161      3.238.213.222

#>
#endregion

#region FIND EC2 INSTANCE WITH NAME CONTAINING 'ecs' ##########################
Get-EC2Instance -Filter @{Name = "tag:Name"; Values = "*ecs*" } | select -ExpandProperty Instances

<#
InstanceId          InstanceType Platform PrivateIpAddress PublicIpAddress
----------          ------------ -------- ---------------- ---------------
i-4b99ef5e790f0b78f a1.medium             10.23.12.6
i-c663d49395afafe35 m4.4xlarge            10.231.33.6
i-2976fd81c6b7b38b9 m5.large              10.23.19.4
#>
#endregion

#region LIST ALL c5d INSTANCE TYPES   ##########################################
Get-EC2InstanceType -Filter @{Name = "instance-type"; Values = "c5d*" } | select InstanceType | sort InstanceType

<#
InstanceType
------------
c5d.12xlarge
c5d.18xlarge
c5d.24xlarge
c5d.2xlarge
c5d.4xlarge
c5d.9xlarge
c5d.large
c5d.metal
c5d.xlarge
#>
#endregion



