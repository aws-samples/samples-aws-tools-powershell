#region GET THE TOTAL SIZE OF OBJECTS IN AN S3 FOLDER ###################################
Get-S3Object "cf-templates-xn4sza12ehsj2-us-east-1" -Prefix "my/folder" | Measure-Object -Property Size -Sum

<#
Count             : 13
Average           :
Sum               : 8178
Maximum           :
Minimum           :
StandardDeviation :
Property          : Size
#>
#endregion

#region GET THE TOTAL SIZE OF OBJECTS IN AN S3 FOLDER IN MB ###################################
(Get-S3Object "cf-templates-xn4sza12ehsj2-us-east-1" -Prefix "my/folder" | Measure-Object -Property Size -Sum).Sum / 1MB

<#
355
#>
#endregion
