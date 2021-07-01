#region LIST ALARMS AND STATUS   #############################################
Get-CWAlarm | select AlarmName, StateValue

<#
AlarmName            StateValue
---------            ----------
AppCPUHigh-6BCFB1F   OK
AppCPUHigh-1D4A347   ALARM
AppCPULow-098E702    OK
AppCPULow-648AEC4    OK
#>
#endregion

#region TEMPORARILY TRIGGER ALARM STATE ########################################
Get-CWAlarm MyAlarm9AD1856 | Set-CWAlarmState -StateValue OK -StateReason "Testing"
#endregion