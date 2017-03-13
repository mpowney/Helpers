function Remove-SiteCustomAction {

    [CmdletBinding()]
    Param (	
        [Parameter(Mandatory = $true)]$Context, 
        [Parameter(Mandatory = $true)]$Name
    ) 

    $Site = $Context.Site
    $SiteCustomActions = $Site.UserCustomActions
    $Context.Load($SiteCustomActions)
    $Context.ExecuteQuery()

    $SiteCustomActions | % {
        if ($_.Name -eq $Name) {
            $_.DeleteObject()
        }
    }
    $Context.ExecuteQuery()

}
