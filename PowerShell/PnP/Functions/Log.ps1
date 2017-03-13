function Log {
	[CmdletBinding()]
	param(
		[parameter(Mandatory=$true,ValueFromPipeline=$true)][ValidateNotNullOrEmpty()]$Msg,
		[parameter()][String][ValidateSet("Debug", "Error", "Warning", "Info", "Normal", "Success")]$Level = "Normal",
		[parameter()][switch]$NoNewline=$false
	)               

	if ($Level -eq "Warning") {
        $color = "Yellow";
    }
    if ($Level -eq "Error") {
        $color = "Red";
    }
    if($Level -eq "Normal") {
        $color = "White";
    }
    if($Level -eq "Info") {
        $color = "Cyan";
    }
    if($Level -eq "Success") {
        $color = "Green";
    }
	
	if($Verbose -eq $true){
		Write-Verbose $Msg -ForegroundColor $color
	}else{
        if($Level -eq "Debug") {
            Write-Debug $Msg
        } elseif ($Level -eq "Error") {
            Write-Error $Msg

        } else {
            Write-Host $Msg -ForegroundColor $color -NoNewline:$NoNewline;
        }
        
	}
}