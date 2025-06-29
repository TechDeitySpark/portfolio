# Portfolio Configuration Script (PowerShell)
# This script helps you switch between GitHub API and static portfolio modes

Write-Host "=== Portfolio Configuration ===" -ForegroundColor Cyan
Write-Host "Choose your portfolio mode:"
Write-Host "1. GitHub API Integration (Dynamic)"
Write-Host "2. Static Portfolio Configuration" 
Write-Host "3. Hybrid Mode (GitHub API + Featured Projects)"

$choice = Read-Host "Enter your choice (1-3)"

switch ($choice) {
    1 {
        Write-Host "Configuring GitHub API Integration..." -ForegroundColor Yellow
        
        # Prompt for GitHub username
        $githubUsername = Read-Host "Enter your GitHub username"
        
        # Update the JavaScript file
        (Get-Content "assets\js\github-portfolio.js") -replace "TechDeitySpark", $githubUsername | Set-Content "assets\js\github-portfolio.js"
        
        # Update HTML to use GitHub integration
        (Get-Content "index.html") -replace "<!-- <script src=`"assets/js/github-portfolio.js`"></script> -->", "<script src=`"assets/js/github-portfolio.js`"></script>" | Set-Content "index.html"
        (Get-Content "index.html") -replace "<script src=`"assets/js/static-portfolio.js`"></script>", "<!-- <script src=`"assets/js/static-portfolio.js`"></script> -->" | Set-Content "index.html"
        
        Write-Host "✅ GitHub API integration configured!" -ForegroundColor Green
        Write-Host "📝 Your projects will be automatically fetched from GitHub"
        Write-Host "💡 Make sure your repositories are public and have good descriptions"
    }
    2 {
        Write-Host "Configuring Static Portfolio..." -ForegroundColor Yellow
        
        # Update HTML to use static portfolio
        (Get-Content "index.html") -replace "<!-- <script src=`"assets/js/static-portfolio.js`"></script> -->", "<script src=`"assets/js/static-portfolio.js`"></script>" | Set-Content "index.html"
        (Get-Content "index.html") -replace "<script src=`"assets/js/github-portfolio.js`"></script>", "<!-- <script src=`"assets/js/github-portfolio.js`"></script> -->" | Set-Content "index.html"
        
        # Enable static portfolio in the JavaScript file
        $content = Get-Content "assets\js\static-portfolio.js" -Raw
        $content = $content -replace "/\*$", ""
        $content = $content -replace "^\*/", ""
        $content | Set-Content "assets\js\static-portfolio.js"
        
        Write-Host "✅ Static portfolio configured!" -ForegroundColor Green
        Write-Host "📝 Edit assets/js/static-portfolio.js to customize your projects"
        Write-Host "🖼️  Add project images to assets/images/projects/"
    }
    3 {
        Write-Host "Configuring Hybrid Mode..." -ForegroundColor Yellow
        
        # Prompt for GitHub username
        $githubUsername = Read-Host "Enter your GitHub username"
        
        # Update the JavaScript file
        (Get-Content "assets\js\github-portfolio.js") -replace "TechDeitySpark", $githubUsername | Set-Content "assets\js\github-portfolio.js"
        
        # Enable both scripts
        (Get-Content "index.html") -replace "<!-- <script src=`"assets/js/github-portfolio.js`"></script> -->", "<script src=`"assets/js/github-portfolio.js`"></script>" | Set-Content "index.html"
        (Get-Content "index.html") -replace "<!-- <script src=`"assets/js/static-portfolio.js`"></script> -->", "<script src=`"assets/js/static-portfolio.js`"></script>" | Set-Content "index.html"
        
        Write-Host "✅ Hybrid mode configured!" -ForegroundColor Green
        Write-Host "📝 Your GitHub projects will be fetched automatically"
        Write-Host "⭐ You can also add featured projects manually"
        Write-Host "💡 Uncomment the addFeaturedProject examples in github-portfolio.js"
    }
    default {
        Write-Host "❌ Invalid choice. Please run the script again." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "=== Next Steps ===" -ForegroundColor Cyan
Write-Host "1. 🖼️  Add project screenshots to your repositories or assets/images/projects/"
Write-Host "2. 📝 Update project descriptions in your GitHub repos"
Write-Host "3. 🏷️  Add relevant topics/tags to your GitHub repositories"
Write-Host "4. 🌐 Test your portfolio by opening index.html in a browser"
Write-Host "5. 📚 Read GITHUB_PORTFOLIO_SETUP.md for detailed configuration options"

Write-Host ""
Write-Host "🎉 Portfolio configuration complete!" -ForegroundColor Green
