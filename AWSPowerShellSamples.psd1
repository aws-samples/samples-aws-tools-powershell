@{
    ModuleVersion = '0.1.0'
    GUID          = 'cfc26b48-0d28-42dc-ac3c-83008e4b532a'
    Description   = 'Sample Cmdlets for using AWS Tools for PowerShell'
    NestedModules = @(
        "lambda/functions.ps1"
        "cloud-formation/functions.ps1"
    )
}