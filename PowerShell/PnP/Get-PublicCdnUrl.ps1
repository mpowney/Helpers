Param (
    $Url
)

# Replace ~SiteCollection tokens to refer to the actual URL (in case this URL came from a ScriptLink or CustomAction)
$LookupUrl = $Url.ToLower().Replace("~sitecollection", ((Get-PnPSite).Url))

# Find a matching PublicCdnOrigin
$PublicCdn = Get-SPOPublicCdnOrigins | ? { [System.Web.HttpUtility]::UrlDecode($LookupUrl).ToLower().StartsWith([System.Web.HttpUtility]::UrlDecode($_.Url).ToLower()) }

if ($PublicCdn -ne $null) {

    $Hostname = ([System.Uri]$LookupUrl).Host
    $CdnId = $PublicCdn.Id
    $Path = $LookupUrl.ToLower().Replace($PublicCdn.Url.ToLower(), "")

    return "https://publiccdn.sharepointonline.com/$Hostname/$CdnId$Path"

} else {

    return $Url

}