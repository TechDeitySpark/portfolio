# Enable reCAPTCHA v3 after setting up production keys (PowerShell version)

param(
    [Parameter(Mandatory=$true)]
    [string]$SiteKey
)

Write-Host "🔧 Enabling reCAPTCHA v3 in your portfolio..." -ForegroundColor Green

Write-Host "📝 Updating HTML and JavaScript to use site key: $SiteKey" -ForegroundColor Yellow

# Update reCAPTCHA v3 script in HTML
(Get-Content index.html) -replace 'render=YOUR_SITE_KEY_HERE', "render=$SiteKey" | Set-Content index.html

# Update site key in JavaScript file
(Get-Content assets/js/plugins/contact-recaptcha-v3.js) -replace "const RECAPTCHA_SITE_KEY = 'YOUR_SITE_KEY_HERE';", "const RECAPTCHA_SITE_KEY = '$SiteKey';" | Set-Content assets/js/plugins/contact-recaptcha-v3.js

Write-Host "✅ reCAPTCHA v3 enabled successfully!" -ForegroundColor Green
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "   1. Test the form on your live site" -ForegroundColor White
Write-Host "   2. Check browser console for reCAPTCHA logs" -ForegroundColor White
Write-Host "   3. Commit and push changes to GitHub" -ForegroundColor White
Write-Host "   4. Verify form submissions work in production" -ForegroundColor White
Write-Host ""
Write-Host "🌐 Your site: https://techdeityspark.github.io/portfolio" -ForegroundColor Blue
Write-Host "💡 reCAPTCHA v3 is invisible - no checkbox for users!" -ForegroundColor Yellow

# Usage example
Write-Host ""
Write-Host "Usage example:" -ForegroundColor Yellow
Write-Host "  .\enable-recaptcha.ps1 -SiteKey '6LcYourActualV3SiteKeyHere'" -ForegroundColor Gray
Write-Host ""
Write-Host "Note: Make sure you created reCAPTCHA v3 keys (not v2)!" -ForegroundColor Red
