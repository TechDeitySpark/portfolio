# Enable reCAPTCHA after setting up production keys (PowerShell version)

param(
    [Parameter(Mandatory=$true)]
    [string]$SiteKey
)

Write-Host "🔧 Enabling reCAPTCHA in your portfolio..." -ForegroundColor Green

Write-Host "📝 Updating HTML to use site key: $SiteKey" -ForegroundColor Yellow

# Enable reCAPTCHA script
(Get-Content index.html) -replace '<!-- <script src="https://www.google.com/recaptcha/api.js" async defer></script> -->', '<script src="https://www.google.com/recaptcha/api.js" async defer></script>' | Set-Content index.html

# Enable reCAPTCHA widget and update site key
(Get-Content index.html) -replace '<!-- <div class="col-lg-12 mb-3">', '<div class="col-lg-12 mb-3">' | Set-Content index.html
(Get-Content index.html) -replace 'data-sitekey="YOUR_ACTUAL_SITE_KEY_HERE"', "data-sitekey=`"$SiteKey`"" | Set-Content index.html
(Get-Content index.html) -replace '</div> -->', '</div>' | Set-Content index.html

# Switch back to secure contact form with reCAPTCHA
(Get-Content index.html) -replace 'contact-temp-no-recaptcha.js', 'contact-secure.js' | Set-Content index.html

Write-Host "✅ reCAPTCHA enabled successfully!" -ForegroundColor Green
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "   1. Test the form on your live site" -ForegroundColor White
Write-Host "   2. Commit and push changes to GitHub" -ForegroundColor White
Write-Host "   3. Verify reCAPTCHA works in production" -ForegroundColor White
Write-Host ""
Write-Host "🌐 Your site: https://techdeityspark.github.io/portfolio" -ForegroundColor Blue

# Usage example
Write-Host ""
Write-Host "Usage example:" -ForegroundColor Yellow
Write-Host "  .\enable-recaptcha.ps1 -SiteKey '6LcYourActualSiteKeyHere'" -ForegroundColor Gray
