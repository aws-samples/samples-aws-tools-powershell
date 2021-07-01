<#
Represents information about a single execution of a lambda function
#>
class LMInvocation {
    [DateTime]
    $InvocationTime

    [string]
    $InvocationId

    [string]
    $LogStreamName
}

<#
.SYNOPSIS
    Lists most recent invocations of a Lambda function in descending order.

.PARAMETER FunctionName
    Name of the lambda function

.PARAMETER Limit
    Total number of invocations to list.

.EXAMPLE
PS> Get-LMInvocation AppFunction-10D3F11E0

InvocationTime       InvocationId                         LogStreamName
-------------        ---------                            -------------
4/1/2021 6:52:24 PM  87c5b90a-4bf8-4c8b-9ec4-55a25282c728 2021/04/01/[$LATEST]70c203cfa5ca6779442cdcc750459227
3/31/2021 6:52:24 PM 2161923c-5f50-4232-8acc-1de5e2203366 2021/03/31/[$LATEST]a2a0d3f9064b6ebaa236c8f5fae3a354
3/30/2021 6:52:24 PM c639d834-e598-4491-b36f-311ce7d96a63 2021/03/30/[$LATEST]9c7d45c6b221447e952aaf7cd6398106
3/29/2021 6:52:24 PM fd011dde-601d-4fc9-94a4-4edd86f2e341 2021/03/29/[$LATEST]c81190e366742bcb3dad4d13128c2268
3/28/2021 6:52:24 PM f21638b7-6a73-4090-b103-1c1ccc849d27 2021/03/28/[$LATEST]f77070d650e2f249d2773eb13173bb51

#>
function Get-LMInvocation {
    [CmdletBinding()]
    [OutputType([LMInvocation[]])]
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $FunctionName,
        [int]
        $Limit = 5
    )

    $invocations = [LMInvocation[]]@()

    $logGroup = "/aws/lambda/$($FunctionName)"

    :all foreach ($stream in (Get-CWLLogStream -Descending $true $logGroup -OrderBy LastEventTime)) {
        $timestampStart = ([System.DateTimeOffset]$stream.FirstEventTimestamp).ToUnixTimeMilliseconds()
        $timestampEnd = ([System.DateTimeOffset]$stream.LastEventTimestamp).ToUnixTimeMilliseconds()
        do {
            $eventGroup = Get-CWLFilteredLogEvent -FilterPattern '"START RequestId:"' -LogGroupName $logGroup -LogStreamName $stream.LogStreamName -StartTime $timestampStart -EndTime $timestampEnd
            foreach ($event in $eventGroup.Events) {
                $ingestionTime = [System.DateTimeOffset]::FromUnixTimeMilliseconds($event.IngestionTime)
                $invocationId = ($event.Message -split '\s+')[2]
                $invocations += @([LMInvocation]@{InvocationTime = $ingestionTime.DateTime; InvocationId = $invocationId; LogStreamName = $stream.LogStreamName })
                if ($invocations.Count -ge $Limit) {
                    break all
                }
            }
        } while ($null -ne $eventGroup.NextToken)
    }
    $invocations
}