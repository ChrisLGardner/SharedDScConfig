Configuration JeaConfig {
    Param(
        $SessionConfigurations = @(),
        $RoleCapabilities = @()
    )

    Import-DscResource -ModuleName JeaDsc

    foreach ($Role in $RoleCapabilities) {
        if(!$Role.Ensure) { $Role.add('Ensure', 'Present') }
        $Name = $Role.Name
        $Role.Remove('Name')
        (Get-DscSplattedResource -ResourceName 'JeaRoleCapabilities' -ExecutionName "$($Name)_rc" -Properties $Role -NoInvoke).Invoke($Role)
    }

    foreach ($SessionConfiguration in $SessionConfigurations) {
        if(!$SessionConfiguration.Ensure) { $SessionConfiguration.add('Ensure', 'Present') }
        (Get-DscSplattedResource -ResourceName 'JeaSessionConfiguration' -ExecutionName "$($SessionConfiguration.EndpointName)_sc" -Properties $SessionConfiguration -NoInvoke).Invoke($SessionConfiguration)
    }

}
