Param (
    [Parameter(Mandatory)] [PnP.PowerShell.Commands.Base.PipeBinds.ListPipeBind] $List,
    [Parameter(Mandatory)] [PnP.PowerShell.Commands.Base.PipeBinds.ContentTypePipeBind] $ContentType,
    [switch] $IsUpload,
    [string] $TemplateId,
    [string] $Title,
    [string] $Url,
    [switch] $Visible,
    [switch] $WhatIf
)

$View = Get-PnPProperty -ClientObject (Get-PnPList $List) -Property DefaultView
$ContentTypeId = (Get-PnPProperty -ClientObject (Get-PnPContentType $ContentType) -Property Id).StringValue
$CurrentTemplatesJson = Get-PnPProperty -ClientObject $View -Property NewDocumentTemplates
$CurrentTemplates = (ConvertFrom-Json $CurrentTemplatesJson)
$CurrentTemplates += [PSCustomObject]@{
    contentTypeId = $ContentTypeId;
    isUpload = $IsUpload.IsPresent;
    templateId = $TemplateId;
    title = $Title;
    url = $Url;
    visible = $Visible.IsPresent;
}

if ($WhatIf.IsPresent) {
    Return $CurrentTemplates
}
else {

    $Context = Get-PnPContext
    $Context.Load($View)
    $View.NewDocumentTemplates = (ConvertTo-Json $CurrentTemplates)
    $View.Update();
    $Context.ExecuteQuery();

}
