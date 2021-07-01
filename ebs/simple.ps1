#region LIST UN-ENCRYPTED SNAPSHOTS  ###########################################
Get-EC2Snapshot -Owner self -Filter @{Name = "encrypted"; Values = "false" } | select SnapshotId, Description, VolumeSize

<#
SnapshotId    Description            VolumeSize
----------    -----------            ----------
snap-30fb0d9a 1980 US Census (Linux)          2
snap-e280a076 App backup 2021-03-02           2
#>
#endregion

#region SORT ALL SNAPSHOTS BY SIZE ###################################
Get-EC2Snapshot -Owner self | Sort-Object VolumeSize | select SnapshotId, Description, VolumeSize

<#
SnapshotId    Description                       VolumeSize
----------    -----------                       ----------
snap-935b6463 1980 US Census (Linux)                     2
snap-db42015e 1980 US Census (Windows)                   5
snap-7aa917b2 Business/Industry Summary (Linux)        100
snap-d5474f07 Labor Statistics (Linux)                 150
#>
#endregion

#region SORT VOLUMES OLDEST TO NEWEST  #########################################
Get-EC2Volume | Sort-Object CreateTime | select VolumeId, @{Name = 'Name'; Exp = { ($_.Tags | ? Key -EQ Name).Value } }

<#
VolumeId              CreateTime             Name
--------              ----------             ----
vol-cf37e3c7edd871529 4/23/2020 4:38:44 AM
vol-0ce0ebca176b43879 8/19/2020 1:55:04 PM
vol-8588f2fe3be1484ff 10/22/2020 10:08:11 AM Search data volume
vol-8b5d08ac2efeeab73 10/22/2020 10:09:01 AM Search data volume
vol-7a25c5fb7325be55a 3/12/2021 3:20:35 PM
#>
#endregion
