Configuration JeaConfig {
    Param(
        $EndPoints = @(),
        $RoleCapabilities = @()
    )

    Import-DscResource -ModuleName JeaDsc

    foreach ($Role in $RoleCapabilities) {
        if(!$Role.Ensure) { $Role.add('Ensure', 'Present') }
        $Name = $Role.Name
        $Role.Remove('Name')
        (Get-DscSplattedResource -ResourceName 'JeaRoleCapabilities' -ExecutionName "$($Name)_rc" -Properties $Role -NoInvoke).Invoke($Role)
    }

    foreach ($Endpoint in $EndPoints) {
        if(!$Endpoint.Ensure) { $Endpoint.add('Ensure', 'Present') }
        (Get-DscSplattedResource -ResourceName 'JeaEndpoint' -ExecutionName "$($Endpoint.EndpointName)_ep" -Properties $Endpoint -NoInvoke).Invoke($Endpoint)
    }

}
