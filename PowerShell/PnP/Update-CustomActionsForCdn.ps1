# Connect-SPOService -Url https://onenil-admin.sharepoint.com -Credential (Get-Credential)
# Set-SPOTenant -PublicCdnEnabled $true
# New-SPOPublicCdnOrigin -Url "https://onenil.sharepoint.com/Style%20Library/@onenil"
# Connect-PnPOnline -Url https://onenil.sharepoint.com

Get-PnPCustomAction -Scope Site | % {

    Log -Level Info "Checking Custom Action with Url $($_.ScriptSrc)"
    $UpdatedCdnUrl = (.\Get-PublicCdnUrl.ps1 -Url ($_.ScriptSrc))
    if ($_.ScriptSrc -ne $UpdatedCdnUrl) {

        Log -Level Normal "Updating Custom Action with Url $($_.ScriptSrc) to CDN URL $UpdatedCdnUrl"
        Remove-SiteCustomAction -Context (Get-PnPContext) -Name $_.Name
        Add-SiteCustomAction -Context (Get-PnPContext) -ScriptSrc $UpdatedCdnUrl -Sequence $_.Sequence -Name $_.Name

    }

}
