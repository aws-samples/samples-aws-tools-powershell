#region GET STACK EVENTS FOR SINCE YESTERDAY ###################################
Get-CFNStackEvents MyStack | ? Timestamp -GT ([Datetime]::Today.AddDays(-1)) | select Timestamp, ResourceType, ResourceStatus, ResourceStatusReason

<#
Timestamp             ResourceType               ResourceStatus     ResourceStatusReason
---------             ------------               --------------     --------------------
3/25/2021 11:27:28 AM AWS::CloudFormation::Stack CREATE_COMPLETE
3/25/2021 11:27:27 AM AWS::Lambda::Function      CREATE_COMPLETE
3/25/2021 11:27:26 AM AWS::Lambda::Function      CREATE_IN_PROGRESS Resource creation Initiated
3/25/2021 11:27:25 AM AWS::Lambda::Function      CREATE_IN_PROGRESS
3/25/2021 11:27:23 AM AWS::IAM::Role             CREATE_COMPLETE
3/25/2021 11:27:11 AM AWS::CDK::Metadata         CREATE_COMPLETE
3/25/2021 11:27:11 AM AWS::CDK::Metadata         CREATE_IN_PROGRESS Resource creation Initiated
3/25/2021 11:27:10 AM AWS::IAM::Role             CREATE_IN_PROGRESS Resource creation Initiated
#>

#endregion

#region LIST RESOURCES FOR A STACK           ###################################
Get-CFNStackResourceList -StackName MyStack | select ResourceType, PhysicalResourceId | sort ResourceType

<#
ResourceType                          PhysicalResourceId
------------                          ------------------
AWS::AutoScaling::AutoScalingGroup    MyASG-EKU8QAO34XFH
AWS::AutoScaling::AutoScalingGroup    MyOtherASG-95W0YEF2QJE5
AWS::AutoScaling::LaunchConfiguration MyAppLaunchConfig36C49F3C-1BMHB3H1Q1NGH
AWS::AutoScaling::LaunchConfiguration MyOtherAppLaunchConfig36C49F3C-JRGBLC2I954A
AWS::CDK::Metadata                    82234ef0-1786-11ea-a672-0a99e59b1983
AWS::EC2::SecurityGroup               sg-c9e2978508a265cf9
AWS::EC2::SecurityGroup               sg-b5527acbbe1c3fdcf
AWS::ECS::Cluster                     MyCluster
AWS::ECS::Service                     arn:aws:ecs:us-east-1:111111111111:service/MyCluster/MyAppService-1AK6H09A8NPT
AWS::ECS::TaskDefinition              arn:aws:ecs:us-east-1:111111111111:task-definition/datadog-daemon:10
AWS::IAM::InstanceProfile             MyAppRL4WAWInstanceProfile6E077F45-1AK6H09A8NPT
AWS::IAM::InstanceProfile             MyOtherAppNF3ZVInstanceProfile6E077F45-1AK6H09A8NPT
AWS::IAM::Policy                      TaskPolicy-1IMRL4WAWT4N2
AWS::IAM::Policy                      LambdaPolicy-78SV9I14ZH40
AWS::IAM::Policy                      LambdaPolicy-1EAJWQ0DXXPKS
AWS::IAM::Role                        Role9VFUK1-1IMRL4WAWT4N2
AWS::IAM::Role                        LambdaRole9VFUK1-78SV9I14ZH40
AWS::IAM::Role                        LambdaRole9VFUK1-1EAJWQ0DXXPKS
AWS::Lambda::Function                 AppLambdaM4W9IL-AH3EZI15KJ9A
AWS::Lambda::Function                 AppLambdaMZK12I-AH3EZI15KJ9A
AWS::SNS::Subscription                arn:aws:sns:us-east-1:111111111111:AppTopicSub74QVD:0dda3eee-a6a1-494d-9a4d-8f54020769c7
AWS::SNS::Topic                       arn:aws:sns:us-east-1:111111111111:AppTopicN1FNX
#>
#endregion

#region LIST LAMBDA FUNCTIONS IN A STACK     ###################################
Get-CFNStackResourceList -StackName MyStack | ? ResourceType -EQ "AWS::Lambda::Function" | select LogicalResourceId, PhysicalResourceId

<#
LogicalResourceId        PhysicalResourceId
-----------------        ------------------
MyAppLambda887B28EE      MyAppLambda-XI4IHO2A8VVE
CustomResourceH3EZI15KJ9 MyAppCertifiLambada-PFFW7S0743LI
#>
#endregion

#region FIND A STACK THAT DEPLOYS A GIVEN KMS KEY ##############################
Get-CFNStackResources -PhysicalResourceId "bba08d0c-dd4a-474d-84df-85ece3c46d23" | select -First 1 | select StackName

<#
StackName
---------
MyStack
#>
#endregion

#region LIST ALL KMS KEYS DEPLOYED BY CLOUDFORMATION IN AWS REGION #############
Get-CFNStack | % { Get-CFNStackResourceList -StackName $_.StackName } | ? ResourceType -ILike "*::KMS::*" | select StackName, PhysicalResourceId

<#
StackName                PhysicalResourceId
---------                ------------------
AppStack-ZW1963D47X9O    87b05201-5d59-48b9-9dc4-80b650eceedc
AppStack-ZW1963D47X9O    bc73819e-c4aa-4c36-843b-a7e0fa8571d5
AppStack-ZW1963D47X9O    0b23d512-7634-4d07-8dcb-8659e9796981
OtherStack-12N51IXWSPHP  50b6c4ea-de81-4cdf-9cf4-a5aa508efff1
BaseVPC-0064I8FY4KSZ     565cc6bc-3a28-45da-a5e6-df276e62a6b8
#>
#endregion

#region FIND STACKS WITH NAMES CONTAINING 'VPC'  #############
Get-CFNStack | ? StackName -ILike '*VPC*'

<#
StackName           CreationTime         LastUpdatedTime      StackStatus     DisableRollback
---------           ------------         ---------------      -----------     ---------------
BaseVPCEI3QEVLE1Q8H 12/5/2019 9:53:32 AM 9/14/2020 2:01:56 PM UPDATE_COMPLETE False
VPC-9IAHS7980UDZ    8/21/2019 9:58:30 AM 8/23/2019 8:09:05 AM
#>
#endregion

#region LIST RESOURCES THAT WERE NOT DELETED IN A DELETED STACK ################
Get-CFNStackResourceList -StackName "arn:aws:cloudformation:us-east-1:111111111111:stack/MyStack/3bdb33a3-e99e-4a92-a4d9-6044aa4078e8" | ? ResourceStatus -EQ "DELETE_SKIPPED" | select ResourceType, PhysicalResourceId
<#
StackName           CreationTime         LastUpdatedTime      StackStatus     DisableRollback
---------           ------------         ---------------      -----------     ---------------
BaseVPCEI3QEVLE1Q8H 12/5/2019 9:53:32 AM 9/14/2020 2:01:56 PM UPDATE_COMPLETE False
VPC-9IAHS7980UDZ    8/21/2019 9:58:30 AM 8/23/2019 8:09:05 AM
#>
#endregion

#region LIST RECENTLY DELETED STACKS ###########################################
Get-CFNStackSummaries -StackStatusFilter DELETE_COMPLETE | sort DeletionTime -Descending | select StackName, DeletionTime
<#
StackName                    DeletionTime
---------                    ------------
AppTestingStackOSB0U25T7DUQ  3/25/2021 10:10:25 PM
AppTestingStackOSB0U25T7DUQ  3/25/2021 11:28:29 AM
CDKToolkit                   3/25/2021 11:28:23 AM
CDKToolkit                   3/25/2021 11:22:53 AM
#>
#endregion

