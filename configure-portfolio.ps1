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
        if (Test-Path "assets\js\github-portfolio.js") {
            $jsContent = Get-Content "assets\js\github-portfolio.js" -Raw
            $jsContent = $jsContent -replace "TechDeitySpark", $githubUsername
            $jsContent | Set-Content "assets\js\github-portfolio.js"
            Write-Host "✅ Updated GitHub username to: $githubUsername" -ForegroundColor Green
        }
        
        # Check current HTML content
        $htmlContent = Get-Content "index.html" -Raw
        $modified = $false
        
        # Enable GitHub portfolio script if not present
        if (-not ($htmlContent -match 'src="assets/js/github-portfolio\.js"')) {
            $htmlContent = $htmlContent -replace '(\s*<script src="assets/js/plugins/contact-recaptcha-v3\.js"><\/script>)', '$1`n    <script src="assets/js/github-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Added GitHub portfolio script" -ForegroundColor Green
        } elseif ($htmlContent -match '<!--\s*<script src="assets/js/github-portfolio\.js"><\/script>\s*-->') {
            $htmlContent = $htmlContent -replace '<!--\s*<script src="assets/js/github-portfolio\.js"><\/script>\s*-->', '<script src="assets/js/github-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Enabled GitHub portfolio script" -ForegroundColor Green
        } else {
            Write-Host "✅ GitHub portfolio script already enabled" -ForegroundColor Green
        }
        
        # Disable static portfolio script if present
        if ($htmlContent -match '<script src="assets/js/static-portfolio\.js"><\/script>') {
            $htmlContent = $htmlContent -replace '<script src="assets/js/static-portfolio\.js"><\/script>', '<!-- <script src="assets/js/static-portfolio.js"></script> -->'
            $modified = $true
            Write-Host "✅ Disabled static portfolio script" -ForegroundColor Green
        }
        
        if ($modified) {
            $htmlContent | Set-Content "index.html"
        }
        
        Write-Host "✅ GitHub API integration configured!" -ForegroundColor Green
        Write-Host "📝 Your projects will be automatically fetched from GitHub"
        Write-Host "💡 Make sure your repositories are public and have good descriptions"
    }
    2 {
        Write-Host "Configuring Static Portfolio..." -ForegroundColor Yellow
        
        $htmlContent = Get-Content "index.html" -Raw
        $modified = $false
        
        # Enable static portfolio script
        if (-not ($htmlContent -match 'src="assets/js/static-portfolio\.js"')) {
            $htmlContent = $htmlContent -replace '(\s*<script src="assets/js/github-portfolio\.js"><\/script>)', '$1`n    <script src="assets/js/static-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Added static portfolio script" -ForegroundColor Green
        } elseif ($htmlContent -match '<!--\s*<script src="assets/js/static-portfolio\.js"><\/script>\s*-->') {
            $htmlContent = $htmlContent -replace '<!--\s*<script src="assets/js/static-portfolio\.js"><\/script>\s*-->', '<script src="assets/js/static-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Enabled static portfolio script" -ForegroundColor Green
        } else {
            Write-Host "✅ Static portfolio script already enabled" -ForegroundColor Green
        }
        
        # Disable GitHub portfolio script
        if ($htmlContent -match '<script src="assets/js/github-portfolio\.js"><\/script>') {
            $htmlContent = $htmlContent -replace '<script src="assets/js/github-portfolio\.js"><\/script>', '<!-- <script src="assets/js/github-portfolio.js"></script> -->'
            $modified = $true
            Write-Host "✅ Disabled GitHub portfolio script" -ForegroundColor Green
        }
        
        if ($modified) {
            $htmlContent | Set-Content "index.html"
        }
        
        # Enable static portfolio initialization in JS file
        if (Test-Path "assets\js\static-portfolio.js") {
            $jsContent = Get-Content "assets\js\static-portfolio.js" -Raw
            if ($jsContent -match '/\*[\s\S]*?document\.addEventListener[\s\S]*?\*/') {
                $jsContent = $jsContent -replace '/\*([\s\S]*?document\.addEventListener[\s\S]*?)\*/', '$1'
                $jsContent | Set-Content "assets\js\static-portfolio.js"
                Write-Host "✅ Enabled static portfolio initialization" -ForegroundColor Green
            }
        }
        
        Write-Host "✅ Static portfolio configured!" -ForegroundColor Green
        Write-Host "📝 Edit assets/js/static-portfolio.js to customize your projects"
        Write-Host "🖼️  Add project images to assets/images/projects/"
    }
    3 {
        Write-Host "Configuring Hybrid Mode..." -ForegroundColor Yellow
        
        # Prompt for GitHub username
        $githubUsername = Read-Host "Enter your GitHub username"
        
        # Update the JavaScript file
        if (Test-Path "assets\js\github-portfolio.js") {
            $jsContent = Get-Content "assets\js\github-portfolio.js" -Raw
            $jsContent = $jsContent -replace "TechDeitySpark", $githubUsername
            $jsContent | Set-Content "assets\js\github-portfolio.js"
            Write-Host "✅ Updated GitHub username to: $githubUsername" -ForegroundColor Green
        }
        
        $htmlContent = Get-Content "index.html" -Raw
        $modified = $false
        
        # Enable GitHub portfolio script
        if (-not ($htmlContent -match 'src="assets/js/github-portfolio\.js"')) {
            $htmlContent = $htmlContent -replace '(\s*<script src="assets/js/plugins/contact-recaptcha-v3\.js"><\/script>)', '$1`n    <script src="assets/js/github-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Added GitHub portfolio script" -ForegroundColor Green
        } elseif ($htmlContent -match '<!--\s*<script src="assets/js/github-portfolio\.js"><\/script>\s*-->') {
            $htmlContent = $htmlContent -replace '<!--\s*<script src="assets/js/github-portfolio\.js"><\/script>\s*-->', '<script src="assets/js/github-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Enabled GitHub portfolio script" -ForegroundColor Green
        }
        
        # Enable static portfolio script
        if (-not ($htmlContent -match 'src="assets/js/static-portfolio\.js"')) {
            $htmlContent = $htmlContent -replace '(\s*<script src="assets/js/github-portfolio\.js"><\/script>)', '$1`n    <script src="assets/js/static-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Added static portfolio script" -ForegroundColor Green
        } elseif ($htmlContent -match '<!--\s*<script src="assets/js/static-portfolio\.js"><\/script>\s*-->') {
            $htmlContent = $htmlContent -replace '<!--\s*<script src="assets/js/static-portfolio\.js"><\/script>\s*-->', '<script src="assets/js/static-portfolio.js"></script>'
            $modified = $true
            Write-Host "✅ Enabled static portfolio script" -ForegroundColor Green
        }
        
        if ($modified) {
            $htmlContent | Set-Content "index.html"
        }
        
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
