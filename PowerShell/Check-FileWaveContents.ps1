# Example usage:
#  .\Check-FileWaveContents.ps1 | ConvertTo-Csv
#  .\Check-FileWaveContents.ps1 | ConvertTo-Csv | Out-File .\files.csv
#  .\Check-FileWaveContents.ps1 -Path \\Path\To\Wave\Files | ConvertTo-Csv | Out-File .\files.csv

Param (
    [string] $Filter,
    [string] $Path = $pwd
)

Function CheckFileWaveContents {
    Param (
        [string] $Path
    )

    $EndProcessTimeField = @{label="EndProcessTime"; expression={ (Get-Date).ToString("yyyy-MM-dd HH:mm:ss") }}

    $Children = Get-ChildItem -Path $Path -Filter $Filter `
        | Where-Object { $false -eq $_.PSIsContainer } 
    $Children `
        | ForEach-Object {
            [System.Object[]]$OutcomeJson = node ../Node/check-file-contents.mjs $_.FullName

            $Outcome = ConvertFrom-Json($OutcomeJson -join "")
            $Outcome | Select-Object -Property $EndProcessTimeField, filename, size, isWave, ext, mime
        }
    Get-ChildItem -Path $Path -Filter $Filter | Where-Object { $true -eq $_.PSIsContainer } | Where-Object { $true -eq $_.PSIsContainer } | ForEach-Object {
        CheckFileWaveContents -Filter $Filter -Path $_.FullName
    }

}

CheckFileWaveContents -Path $Path
