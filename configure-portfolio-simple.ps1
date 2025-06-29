# Simple Portfolio Configuration Script (PowerShell)

Write-Host "=== Portfolio Configuration ===" -ForegroundColor Cyan
Write-Host "Choose your portfolio mode:"
Write-Host "1. GitHub API Integration (Dynamic) - Fetches projects from GitHub"
Write-Host "2. Static Portfolio Configuration - Manually configured projects" 
Write-Host "3. Show current configuration"

$choice = Read-Host "Enter your choice (1-3)"

switch ($choice) {
    1 {
        Write-Host "Configuring GitHub API Integration..." -ForegroundColor Yellow
        
        # Get GitHub username
        $currentUsername = "TechDeitySpark"
        $githubUsername = Read-Host "Enter your GitHub username (current: $currentUsername)"
        
        if ([string]::IsNullOrWhiteSpace($githubUsername)) {
            $githubUsername = $currentUsername
        }
        
        # Update GitHub username in JS file
        if (Test-Path "assets\js\github-portfolio.js") {
            $jsContent = Get-Content "assets\js\github-portfolio.js" -Raw
            $jsContent = $jsContent -replace "TechDeitySpark", $githubUsername
            $jsContent | Set-Content "assets\js\github-portfolio.js" -Encoding UTF8
            Write-Host "Updated GitHub username to: $githubUsername" -ForegroundColor Green
        } else {
            Write-Host "GitHub portfolio script not found" -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "GitHub API integration configured!" -ForegroundColor Green
        Write-Host "Your portfolio will now fetch projects from: https://github.com/$githubUsername" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "To optimize the display:" -ForegroundColor Yellow
        Write-Host "  - Add screenshots to your repos (screenshot.png, demo.png, preview.png)"
        Write-Host "  - Write clear descriptions for your repositories"
        Write-Host "  - Add topics/tags to categorize your projects"
        Write-Host "  - Set homepage URLs for live demos"
    }
    2 {
        Write-Host "Configuring Static Portfolio..." -ForegroundColor Yellow
        
        # Check if static portfolio file exists
        if (Test-Path "assets\js\static-portfolio.js") {
            $jsContent = Get-Content "assets\js\static-portfolio.js" -Raw
            
            # Check if static configuration is already enabled
            if ($jsContent -match "document\.addEventListener.*StaticPortfolio.*renderProjects") {
                Write-Host "Static portfolio is already configured!" -ForegroundColor Green
            } else {
                Write-Host "Please manually uncomment the initialization code at the bottom of static-portfolio.js" -ForegroundColor Yellow
            }
        } else {
            Write-Host "Static portfolio script not found" -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "Static portfolio configured!" -ForegroundColor Green
        Write-Host "Edit assets/js/static-portfolio.js to customize your projects" -ForegroundColor Cyan
        Write-Host "Add project images to assets/images/projects/" -ForegroundColor Cyan
    }
    3 {
        Write-Host "=== Current Configuration ===" -ForegroundColor Cyan
        Write-Host ""
        
        # Check HTML file for active scripts
        if (Test-Path "index.html") {
            $htmlContent = Get-Content "index.html" -Raw
            
            $githubEnabled = $htmlContent -match 'src="assets/js/github-portfolio\.js"'
            $staticEnabled = $htmlContent -match 'src="assets/js/static-portfolio\.js"'
            
            Write-Host "Script Status:" -ForegroundColor Yellow
            Write-Host "  GitHub Portfolio: $(if($githubEnabled){'Enabled'}else{'Disabled'})" 
            Write-Host "  Static Portfolio: $(if($staticEnabled){'Enabled'}else{'Disabled'})"
            Write-Host ""
            
            if ($githubEnabled -and $staticEnabled) {
                Write-Host "Current Mode: Hybrid (GitHub + Static)" -ForegroundColor Magenta
            } elseif ($githubEnabled) {
                Write-Host "Current Mode: GitHub API Integration" -ForegroundColor Green
            } elseif ($staticEnabled) {
                Write-Host "Current Mode: Static Configuration" -ForegroundColor Blue
            } else {
                Write-Host "Current Mode: No portfolio scripts enabled" -ForegroundColor Red
            }
        }
        
        # Check GitHub username
        if (Test-Path "assets\js\github-portfolio.js") {
            $jsContent = Get-Content "assets\js\github-portfolio.js" -Raw
            if ($jsContent -match "new GitHubPortfolio\('([^']+)'") {
                $username = $matches[1]
                Write-Host "GitHub Username: $username" -ForegroundColor Cyan
                Write-Host "Repository URL: https://github.com/$username" -ForegroundColor Cyan
            }
        }
    }
    default {
        Write-Host "Invalid choice. Please run the script again." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Quick Tips:" -ForegroundColor Cyan
Write-Host "- Open index.html in your browser to test the portfolio"
Write-Host "- Check browser console (F12) for any JavaScript errors"  
Write-Host "- GitHub API has rate limits (60 requests/hour without auth)"
Write-Host "- For help, check GITHUB_PORTFOLIO_SETUP.md"
Write-Host ""
Write-Host "Configuration complete!" -ForegroundColor Green
