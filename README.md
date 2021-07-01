# Samples for AWS Tools for PowerShell

The [AWS Tools for PowerShell](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-welcome.html) can be a
a great tool for engineers who create and manage resources on AWS. The goals of this project are to make it
easier to learn the tools, demonstrate the power and flexibility of the tools, and inspire creativity in the community.

## Samples

| Path | Description
| ---  | -----------
| [s3/simple.ps1](s3/simple.ps1) | List, sort, filter S3 buckets and objects
| [ec2/simple.ps1](ec2/simple.ps1) | One-liners for listing, filtering EC2 resources
| [ebs/simple.ps1](ebs/simple.ps1) | One-liners for EBS snapshots and volumes
| [cloud-formation/simple.ps1](cloud-formation/simple.ps1) | One-liners for CloudFormation stacks & resources
| [cloud-formation/functions.ps1](cloud-formation/functions.ps1) | Sample functions extending CloudFormation cmdlets
| [cloudwatch/simple.ps1](cloudwatch/simple.ps1) | One-liners for CloudWatch
| [lambda/functions.ps1](lambda/functions.ps1) | Sample functions for interacting with AWS Lambda functions.
| [ecs/simple.ps1](ecs/simple.ps1) | One-liners for ECS clusters, services, and task definitions

## Sample Module

See interactive examples of all of the functions defined in this repo by importing the module at the root of this repo.

```
PS > Import-Module ./AWSPowerShellSamples.psd1
PS > Get-Command -Module AWSPowerShellSamples

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Find-CFNStackResourceByPhysicalResourceId          0.1.0      AWSPowerShellSamples
Function        Find-CFNStackResourceByType                        0.1.0      AWSPowerShellSamples
Function        Get-LMInvocation                                   0.1.0      AWSPowerShellSamples
...
```

### Discover Sample Functions

```
PS > help Get-LMInvocation

NAME
    Get-LMInvocation

SYNOPSIS
    Lists most recent invocations of a Lambda function in descending order.


    -------------------------- EXAMPLE 1 --------------------------

    PS>Get-LMInvocation AppFunction-10D3F11E0

    InvocationTime       InvocationId                         LogStreamName
    -------------        ---------                            -------------
    4/1/2021 6:52:24 PM  87c5b90a-4bf8-4c8b-9ec4-55a25282c728 2021/04/01/[$LATEST]70c203cfa5ca6779442cdcc750459227
    3/31/2021 6:52:24 PM 2161923c-5f50-4232-8acc-1de5e2203366 2021/03/31/[$LATEST]a2a0d3f9064b6ebaa236c8f5fae3a354
    3/30/2021 6:52:24 PM c639d834-e598-4491-b36f-311ce7d96a63 2021/03/30/[$LATEST]9c7d45c6b221447e952aaf7cd6398106
    3/29/2021 6:52:24 PM fd011dde-601d-4fc9-94a4-4edd86f2e341 2021/03/29/[$LATEST]c81190e366742bcb3dad4d13128c2268
    3/28/2021 6:52:24 PM f21638b7-6a73-4090-b103-1c1ccc849d27 2021/03/28/[$LATEST]f77070d650e2f249d2773eb13173bb51
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
