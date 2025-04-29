$blogDirPath = "./posts/"
$highestPostNumber = 0

if (-not (Test-Path -Path $blogDirPath)) {
    Write-Host "The specified path does not exist."
    Write-Host "Creating the directory at $blogDirPath..."
    New-Item -Path $blogDirPath -ItemType Directory -Force | Out-Null
    Write-Host "Directory created successfully."
} else {
    Write-Host "The specified path exists. Continuing..."
}

Get-ChildItem -Path $blogDirPath -Filter "post-*.json" | ForEach-Object {
    if ($_ -match "post-(\d+)\.json") {
        $postNumber = [int]$matches[1]
        if ($postNumber -gt $highestPostNumber) {
            $highestPostNumber = $postNumber
        }
    }
}

$nextPostNumber = $highestPostNumber + 1
$blogFileNumberName = "post-" + $nextPostNumber + ".json"
$blogFilePath = Join-Path -Path $blogDirPath -ChildPath $blogFileNumberName

$blogFileContent = @{
    "title" = Read-Host "Enter the title of the blog post"
    "content" = Read-Host "Enter the content of the blog post"
}

$blogFileContent | ConvertTo-Json -Depth 10 | Set-Content -Path $blogFilePath -Encoding UTF8
Write-Host "Blog post created at $blogFilePath"

$totalpostFilePath = Join-Path -Path $blogDirPath -ChildPath "total-posts.json"
while (-not (Test-Path -Path $totalpostFilePath)) {
    Start-Sleep -Seconds 1
    if (-not (Test-Path -Path $totalpostFilePath)) {
        break
    } else {
        Write-Host "Waiting for total-posts.json to be released..."
        New-Item -Path $totalpostFilePath -ItemType File -Force | Out-Null
        Write-Host "total-posts.json file created successfully."
    }
}

$allPosts = Get-ChildItem -Path $blogDirPath -Filter "post-*.json"
$totalPosts = $allPosts.Count
$totalPostsObj = @{ totalPosts = $totalPosts }
$totalPostsObj | ConvertTo-Json | Set-Content -Path (Join-Path $blogDirPath "total-posts.json") -Encoding UTF8

Write-Host "Blog post created at $blogFilePath"
Write-Host "Total posts updated in total-posts.json"