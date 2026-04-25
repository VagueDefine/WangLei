param(
    [string]$SourcePath = "",
    [switch]$CleanOnly
)

# If -CleanOnly flag is used, skip copy
if ($CleanOnly) {
    Write-Host "Clean only mode..."
} else {
    # If no path provided, prompt for input
    if ($SourcePath -eq "") {
        Write-Host "Enter source folder path:" -NoNewline
        $SourcePath = Read-Host
    }

    # If still empty, skip copy
    if ($SourcePath -eq "") {
        Write-Host "No source path provided. Skipping copy."
    } else {
        # Verify source exists
        if (-not (Test-Path $SourcePath)) {
            Write-Host "Error: Source folder not found: $SourcePath" -ForegroundColor Red
            exit 1
        }

        # Get absolute path
        $SourcePath = (Resolve-Path $SourcePath).Path
        $CurrentFolder = $PWD.Path

        Write-Host "Source: $SourcePath"
        Write-Host "Target: $CurrentFolder"

        # Copy files (preserve directory structure)
        $CopiedCount = 0
        Get-ChildItem -Path $SourcePath -Recurse -File | ForEach-Object {
            $RelativePath = $_.FullName.Substring($SourcePath.Length).TrimStart('\')
            $DestPath = Join-Path $CurrentFolder $RelativePath

            $DestDir = Split-Path $DestPath -Parent
            if (-not (Test-Path $DestDir)) {
                New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
            }

            Copy-Item -Path $_.FullName -Destination $DestPath -Force
            $CopiedCount++
        }

        Write-Host "Done! Copied $CopiedCount files"
    }
}

# Clean .git folders
Get-ChildItem -Path . -Recurse -Directory -Filter ".git" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -Directory -Filter ".obsidian" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -Directory -Filter ".trash" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -Directory -Filter "000Excaildraw" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -Directory -Filter "000templates" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -Directory -Filter "main" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -Directory -Filter "ExportDocument" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue


Get-ChildItem -Path . -Recurse -File -Filter ".gitignore" -Force | Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -File -Filter ".gitattributes" -Force | Remove-Item -Force -ErrorAction SilentlyContinue

Write-Host "Cleanup done!"