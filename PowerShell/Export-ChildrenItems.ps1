# Example usage:
#  .\Export-ChildrenItems.ps1 | ConvertTo-Csv
#  .\Export-ChildrenItems.ps1 | ConvertTo-Csv | Out-File .\files.csv
#  .\Export-ChildrenItems.ps1 -Path C:\ | ConvertTo-Csv | Out-File .\files.csv

Param (
    [string] $Filter,
    [string] $Path = $pwd
)

Function ExportChildrenItems {
    Param (
        [string] $Filter,
        [string] $Path
    )

    $ParentField = @{label="Folder"; expression={$_.PSParentPath.Substring($_.PSParentPath.LastIndexOf("::") + 2)}}
    $SizeField = @{label="Size"; expression={($_ | Measure-Object -Sum Length).Sum}}
    $Children = Get-ChildItem -Path $Path -Filter $Filter `
        | Where-Object { $false -eq $_.PSIsContainer } 
    $Children 
        | Select-Object -Property FullName, $ParentField, Name, Extension, $SizeField, LastWriteTime, LastAccessTime, CreationTime
    Get-ChildItem -Path $Path -Filter $Filter | Where-Object { $true -eq $_.PSIsContainer } | Where-Object { $true -eq $_.PSIsContainer } | ForEach-Object {
        ExportChildrenItems -Filter $Filter -Path $_.FullName
    }
}

ExportChildrenItems -Path $Path -Filter $Filter