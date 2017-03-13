function Add-SiteCustomAction {

    [CmdletBinding()]
	Param (	
        [Parameter(Mandatory = $true)]$Context, 
        [Parameter(Mandatory = $true)]$ScriptSrc, 
        [Parameter(Mandatory = $true)]$Sequence, 
        [Parameter(Mandatory = $true)]$Name
    ) 

    $Site = $Context.Site
    $SiteCustomActions = $Site.UserCustomActions
    $NewCustomAction = $SiteCustomActions.Add()
    $NewCustomAction.Location = "ScriptLink"
    $NewCustomAction.ScriptSrc = $ScriptSrc
    $NewCustomAction.Sequence = $Sequence
    $NewCustomAction.Name = $Name
    $NewCustomAction.Update()
    $Context.ExecuteQuery()

}