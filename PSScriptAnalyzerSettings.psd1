@{
    Rules        = @{
        PSAvoidUsingCmdletAliases = @{
            Whitelist = @("Select", "Sort", "?", "%")
        }
    };
    ExcludeRules = @('PSUseBOMForUnicodeEncodedFile')
}