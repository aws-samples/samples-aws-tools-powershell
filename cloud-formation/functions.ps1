<#
.SYNOPSIS
    Lists resources of a given type across all CloudFormation stacks.

.PARAMETER ResourceTypePattern
    A CloudFormation resource type with optional '*' wildcard.

.EXAMPLE
PS> Find-CFNStackResourceByType 'AWS::S3::Bucket' | Select StackName,PhysicalResourceId

StackName   PhysicalResourceId
---------   ------------------
AppStack1   app-bucket-us-east-1-6sa4xg1xq16p
AppStack3   other-bucket-hgv3m097hxzm

.EXAMPLE
PS> Find-CFNStackResource 'AWS::ECS::*' | Select StackName,ResourceType,LogicalResourceId

StackName    ResourceType               LogicalResourceId
---------    ------------               -----------------
AppStack1    AWS::ECS::Cluster          Cluster7C30E250
AppStack1    AWS::ECS::TaskDefinition   TaskDef73DD0A5C
AppStack1    AWS::ECS::Service          ECSServiceB28870C5
OtherStack   AWS::ECS::Cluster          Cluster4D321FF5
OtherStack   AWS::ECS::TaskDefinition   TaskDefDAA7FDA2
OtherStack   AWS::ECS::Service          ECSServiceB0200C36
OtherStack   AWS::ECS::CapacityProvider CapacityProvider2BB42F92

#>
function Find-CFNStackResourceByType {
    [OutputType("Amazon.CloudFormation.Model.StackResource")]
    [CmdletBinding()]
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $ResourceType
    )

    $stackCount = (Get-CFNStack | Measure-Object).Count
    $processed = 0
    $allResources = @()
    foreach ($stack in Get-CFNStack) {
        Write-Progress -PercentComplete ($processed++ / $stackCount * 100) -Activity "Processing $($stack.StackName)"
        Write-Verbose "Processing $($stack.StackName)"
        $resources = Get-CFNStackResourceList -StackName $stack.StackName `
        | Where-Object ResourceType -iLike $ResourceType
        $allResources += $resources
    }
    $allResources
}

<#
.SYNOPSIS
    Find a CloudFormation stack resource by physical id.

.PARAMETER PhysicalResourceId
    Physical id of a CloudFormation resource.

.EXAMPLE

PS> Find-CFNStackResourceByPhysicalResourceId 'e13b1eb2-8291-49b3-9cf5-23d85334685c'

Description          :
DriftInformation     : Amazon.CloudFormation.Model.StackResourceDriftInformation
LogicalResourceId    : AppKMSKeyBA578B0
PhysicalResourceId   : e13b1eb2-8291-49b3-9cf5-23d85334685c
ResourceStatus       : CREATE_COMPLETE
ResourceStatusReason :
ResourceType         : AWS::KMS::Key
StackId              : arn:aws:cloudformation:us-east-1:111111111111:stack/AppStack-76503E7
StackName            : AppStack-76503E7
Timestamp            : 2/20/2020 6:05:57 PM
#>
function Find-CFNStackResourceByPhysicalResourceId {
    [OutputType("Amazon.CloudFormation.Model.StackResource")]
    [CmdletBinding()]
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $PhysicalResourceId
    )

    Get-CFNStackResourceList -PhysicalResourceId $PhysicalResourceId | ? PhysicalResourceId -EQ $PhysicalResourceId
}