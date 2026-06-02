---
title: delete-trash.ps1 - 删除.trash文件夹的PowerShell脚本
tags:
  - PowerShell
  - 批处理
  - 文件清理
source:
author: WangLei
created: 2024-06-02
modified:
  "2024-06-02": 
description: PowerShell脚本，用于递归删除当前目录及其子目录中的所有.trash文件夹
aliases:
  - 删除trash文件夹脚本
draft: false
---

## 一、脚本功能

### 1.1 基本功能
该PowerShell脚本用于删除当前文件夹及其所有子文件夹中的`.trash`文件夹。这是Obsidian笔记软件在同步过程中可能创建的临时文件夹，通常包含不需要的缓存或临时文件。

### 1.2 主要特点
- 递归删除所有子目录中的.trash文件夹
- 显示删除的文件夹路径
- 运行完成后显示完成信息
- 包含用户确认退出机制

## 二、脚本代码

### 2.1 完整代码
```powershell
Write-Host "正在删除当前文件夹及子文件夹中的所有 .trash 文件夹..."
Get-ChildItem -Path . -Recurse -Directory -Filter ".trash" | ForEach-Object {
    Remove-Item -Path $_.FullName -Recurse -Force
    Write-Host "已删除: $($_.FullName)"
}
Write-Host "删除完成！"
Read-Host "按回车键退出"
```

### 2.2 代码解析
- `Write-Host`：显示提示信息
- `Get-ChildItem`：查找所有.trash文件夹（递归搜索）
- `ForEach-Object`：对每个找到的文件夹执行操作
- `Remove-Item`：删除文件夹及其内容
- `Read-Host`：等待用户按回车键退出

## 三、使用方法

### 3.1 运行方式
1. 将脚本保存为 `delete-trash.ps1`
2. 右键点击选择"使用PowerShell运行"
3. 或在PowerShell中运行：`.\delete-trash.ps1`

### 3.2 注意事项
- 需要PowerShell执行权限
- 可能需要设置执行策略：`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`
- 确保有足够的权限删除目标文件夹

## 参考

- [PowerShell官方文档](https://learn.microsoft.com/zh-cn/powershell/)
- [Obsidian同步机制](https://help.obsidian.md/Advanced%20topics/Sync)

---

*创建时间：2024-06-02*
*修改时间：2024-06-02*