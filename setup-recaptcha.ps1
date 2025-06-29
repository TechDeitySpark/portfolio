# reCAPTCHA Setup Script for Portfolio Contact Form (PowerShell)

Write-Host "🔐 reCAPTCHA Setup for Portfolio Contact Form" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green
Write-Host ""

Write-Host "📋 Follow these steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Go to: https://www.google.com/recaptcha/admin/create" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Fill out the form:" -ForegroundColor Yellow
Write-Host "   Label: Portfolio Contact Form" -ForegroundColor White
Write-Host "   Type: reCAPTCHA v2 → 'I'm not a robot' Checkbox" -ForegroundColor White
Write-Host "   Domains:" -ForegroundColor White
Write-Host "     - techdeityspark.github.io" -ForegroundColor Gray
Write-Host "     - localhost" -ForegroundColor Gray
Write-Host "     - 127.0.0.1" -ForegroundColor Gray
Write-Host ""

$siteKey = Read-Host "3. Enter your reCAPTCHA Site Key (starts with 6L...)"

if ([string]::IsNullOrWhiteSpace($siteKey)) {
    Write-Host "❌ No site key provided. Exiting..." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🔧 Updating index.html with your site key..." -ForegroundColor Yellow

# Read the HTML file
$htmlContent = Get-Content "index.html" -Raw

# Replace the placeholder with actual site key
$updatedContent = $htmlContent -replace "YOUR_SITE_KEY_HERE", $siteKey

# Write back to file
Set-Content "index.html" -Value $updatedContent

Write-Host "✅ reCAPTCHA has been configured!" -ForegroundColor Green
Write-Host ""
Write-Host "🚀 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Test your form locally" -ForegroundColor White
Write-Host "   2. Commit and push changes:" -ForegroundColor White
Write-Host "      git add ." -ForegroundColor Gray
Write-Host "      git commit -m 'Enable reCAPTCHA for contact form'" -ForegroundColor Gray
Write-Host "      git push origin main" -ForegroundColor Gray
Write-Host ""
Write-Host "🌐 Your secure contact form will be live at:" -ForegroundColor Cyan
Write-Host "   https://techdeityspark.github.io/portfolio/" -ForegroundColor White
Write-Host ""
Write-Host "🔒 Security features now active:" -ForegroundColor Green
Write-Host "   ✅ reCAPTCHA bot protection" -ForegroundColor White
Write-Host "   ✅ Honeypot anti-spam" -ForegroundColor White
Write-Host "   ✅ Rate limiting" -ForegroundColor White
Write-Host "   ✅ Input sanitization" -ForegroundColor White
Write-Host "   ✅ Suspicious content detection" -ForegroundColor White
