Write-Host "正在删除当前文件夹及子文件夹中的所有 .trash 文件夹..."
Get-ChildItem -Path . -Recurse -Directory -Filter ".trash" | ForEach-Object {
    Remove-Item -Path $_.FullName -Recurse -Force
    Write-Host "已删除: $($_.FullName)"
}
Write-Host "删除完成！"
Read-Host "按回车键退出"