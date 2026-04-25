# Delete .git folders in current folder and all subfolders
Get-ChildItem -Path . -Recurse -Directory -Filter ".git" -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# Also delete .gitignore and .gitattributes files
Get-ChildItem -Path . -Recurse -File -Filter ".gitignore" -Force | Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path . -Recurse -File -Filter ".gitattributes" -Force | Remove-Item -Force -ErrorAction SilentlyContinue

Write-Host "Done!"