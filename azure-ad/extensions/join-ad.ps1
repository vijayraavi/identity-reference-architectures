# $DomainName         -  The fully qualified domain name (FQDN) of the domain the computer will be joining.
# $Credentials         - a PSCredentials object that contains username and password 
#                        to autenticate with the domain
# $RetryCount         -  defines how many retries should be performed while waiting
#                        for the domain to be provisioned
# $RetryIntervalSec   -  defines the seconds between each retry to check if the 
#                        domain has been provisioned
Configuration JoinAD {
    param
    #v1.4
    (
        [Parameter(Mandatory)]
        [string]$DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Credentials,

        [Int]$RetryCount=30,
        [Int]$RetryIntervalSec=60
    )

    Import-DscResource -Module xActiveDirectory, xPendingReboot, xComputerManagement

    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Credentials.UserName)", $Credentials.Password)
    
    Node localhost
    {
        LocalConfigurationManager
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true            
        } 

        xWaitForADDomain DscForestWait 
        { 
            DomainName = $DomainName 
            DomainUserCredential= $DomainCreds
            RetryCount = $RetryCount 
            RetryIntervalSec = $RetryIntervalSec
        }
         
        xComputer JoinDomain
        {
            Name          = $env:COMPUTERNAME
            DomainName    = $DomainName
            Credential    = $DomainCreds  # Credential to join to domain
            DependsOn = "[xWaitForADDomain]DscForestWait"
        }

        xPendingReboot Reboot2
        { 
            Name = "RebootServer"
            DependsOn = "[xComputer]JoinDomain"
        }

   }
}