# PowerShell deployment script for portfolio website

Write-Host "🚀 Deploying portfolio website..." -ForegroundColor Green

# Add all changes
git add .

# Commit with timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "Update portfolio - $timestamp"

# Push to GitHub
git push origin main

Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host "🌐 Your site will be updated at: https://YOUR_USERNAME.github.io/YOUR_REPOSITORY_NAME" -ForegroundColor Cyan
