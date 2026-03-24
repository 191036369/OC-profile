# Daily Learning Script
# 执行时机：每天 21:00

param(
    [string]$Date = (Get-Date -Format "yyyy-MM-dd")
)

$Workspace = "C:\Users\七彩虹\.openclaw\workspaces\ozon"
$MemoryFile = "$Workspace\memory\$Date.md"
$ArchiveFile = "$Workspace\memory\archive\$Date.md"
$MemoryCore = "$Workspace\MEMORY.md"

Write-Host "=== 每日学习开始: $Date ==="

# 检查今日是否有记录
if (-not (Test-Path $MemoryFile)) {
    Write-Host "今日无对话记录，跳过学习"
    exit 0
}

# 读取今日记录
$todayNotes = Get-Content $MemoryFile -Raw -Encoding UTF8

# 提取关键信息（简化版，实际由 AI 模型分析）
$summary = @"

## $Date 学习摘要

### 今日对话主题
[待 AI 分析提取]

### 新增偏好
[待分析]

### 重要决策
[待记录]

### 待跟进事项
[待确认]

---
*自动生成于 $(Get-Date -Format "yyyy-MM-dd HH:mm")*
"@

# 追加到 MEMORY.md
$currentContent = Get-Content $MemoryCore -Raw -Encoding UTF8
$newContent = $currentContent -replace '(## 📅 学习日志\r?\n)', "$($summary)`n`n$1"

# 更新 MEMORY.md
$newContent | Set-Content $MemoryCore -Encoding UTF8

# 归档今日记录
Copy-Item $MemoryFile $ArchiveFile -Force

Write-Host "学习完成，已更新 MEMORY.md"
Write-Host "今日记录已归档"
