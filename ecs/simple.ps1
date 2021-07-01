#region GET THE TASK DEFINITION ARN OF AN ECS SERVICE ##########################
(Get-ECSService -Cluster 'AppCluster' -Service "AppService1").Services.TaskDefinition

<#
arn:aws:ecs:us-east-1:808210643485:task-definition/OnPointPortalEntityLogsBackenddevEcsResourcesTaskDefinition2B40DE98:101
#>
#endregion

#region GET RECENT EVENTS FOR AN ECS SERVICE          ##########################
(Get-ECSService -Cluster 'AppCluster' -Service "AppService1").Services.Events


<#
CreatedAt             Id                                   Message
---------             --                                   -------
3/26/2021 3:04:39 PM  ebfa105a-64dd-4c99-9013-d4c3a5123b18 (service AppService1) has reached a steady state.
3/26/2021 9:04:29 AM  f13b52df-cd12-4a01-881d-162bf7d636db (service AppService1) has reached a steady state.
3/25/2021 9:02:33 AM  adc75268-7b3e-430a-a9c4-114ae2d1f339 (service AppService1) has reached a steady state.
3/25/2021 9:02:22 AM  31cb0112-6646-49c3-b5cf-734d8ac0ebce (service AppService1, taskSet ecs-svc/8318400716762185021) updated state to STEADY_STATE.
3/25/2021 9:02:22 AM  d13bf377-8a3c-4bf5-9175-3abe8712bdfa (service AppService1) updated computedDesiredCount for taskSet ecs-svc/8318400716762185021 to…
3/25/2021 8:02:36 AM  1a1b14ef-5eee-4d61-8825-34870af59d4a (service AppService1) was unable to place a task because no container instance met all of its…
3/25/2021 8:02:36 AM  6d8ba78b-142b-4a60-be8e-e22b5768cdee (service AppService1) updated computedDesiredCount for taskSet ecs-svc/8318400716762185021 to…
3/25/2021 4:14:54 AM  c4aa8c31-5bd4-4301-b930-efb0dbbb65cf (service AppService1) has reached a steady state.
#>
#endregion

#region GET ENVIRONMENT VARIABLES OF CONTAINER        ##########################
(Get-ECSTaskDefinitionDetail "AppTask1:26").TaskDefinition.ContainerDefinitions.Environment

<#
Name                                            Value
----                                            -----
AWS_REGION                                      us-east-1
ASPNETCORE_ENVIRONMENT                          dev
#>
#endregion

#region LIST CONTAINER IMAGES IN A TASK DEFINITION    ##########################
Get-ECSTaskDefinitionDetail -TaskDefinition 'arn:aws:ecs:us-east-1:111111111111:task-definition/apptask:233' -Select TaskDefinition.ContainerDefinitions | select Name, Image

<#
Name            Image
----            -----
WebApplication  111111111111.dkr.ecr.us-east-1.amazonaws.com/WebApplication:20210301
XRay            public.ecr.aws/xray/aws-xray-daemon:alpha
#>
#endregion

#region SHOW ALL CONTAINER IMAGES DEFINED IN TASK DEFINITIONS FOR A REGION #####
(Get-ECSTaskDefinitionList | Get-ECSTaskDefinitionDetail).TaskDefinition.ContainerDefinitions.Image | select -Unique

<#
nginx:latest
amazon/aws-xray-daemon:3.x
public.ecr.aws/xray/aws-xray-daemon:alpha
docker.io/nginx:latest
111111111111.dkr.ecr.us-east-1.amazonaws.com/webapp:20210401
111111111111.dkr.ecr.us-east-1.amazonaws.com/webapp:20210316
111111111111.dkr.ecr.us-east-1.amazonaws.com/webapp:20210328
....
#>
#endregion
