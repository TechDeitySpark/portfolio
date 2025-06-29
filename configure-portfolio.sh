#!/bin/bash

# Portfolio Configuration Script
# This script helps you switch between GitHub API and static portfolio modes

echo "=== Portfolio Configuration ==="
echo "Choose your portfolio mode:"
echo "1. GitHub API Integration (Dynamic)"
echo "2. Static Portfolio Configuration"
echo "3. Hybrid Mode (GitHub API + Featured Projects)"

read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        echo "Configuring GitHub API Integration..."
        
        # Prompt for GitHub username
        read -p "Enter your GitHub username: " github_username
        
        # Update the JavaScript file
        sed -i "s/TechDeitySpark/$github_username/g" assets/js/github-portfolio.js
        
        # Update HTML to use GitHub integration
        sed -i 's/<!-- <script src="assets\/js\/github-portfolio.js"><\/script> -->/<script src="assets\/js\/github-portfolio.js"><\/script>/' index.html
        sed -i 's/<script src="assets\/js\/static-portfolio.js"><\/script>/<!-- <script src="assets\/js\/static-portfolio.js"><\/script> -->/' index.html
        
        echo "✅ GitHub API integration configured!"
        echo "📝 Your projects will be automatically fetched from GitHub"
        echo "💡 Make sure your repositories are public and have good descriptions"
        ;;
    2)
        echo "Configuring Static Portfolio..."
        
        # Update HTML to use static portfolio
        sed -i 's/<!-- <script src="assets\/js\/static-portfolio.js"><\/script> -->/<script src="assets\/js\/static-portfolio.js"><\/script>/' index.html
        sed -i 's/<script src="assets\/js\/github-portfolio.js"><\/script>/<!-- <script src="assets\/js\/github-portfolio.js"><\/script> -->/' index.html
        
        # Enable static portfolio in the JavaScript file
        sed -i 's/\/\*$//' assets/js/static-portfolio.js
        sed -i 's/^\*\///' assets/js/static-portfolio.js
        
        echo "✅ Static portfolio configured!"
        echo "📝 Edit assets/js/static-portfolio.js to customize your projects"
        echo "🖼️  Add project images to assets/images/projects/"
        ;;
    3)
        echo "Configuring Hybrid Mode..."
        
        # Prompt for GitHub username
        read -p "Enter your GitHub username: " github_username
        
        # Update the JavaScript file
        sed -i "s/TechDeitySpark/$github_username/g" assets/js/github-portfolio.js
        
        # Enable both scripts
        sed -i 's/<!-- <script src="assets\/js\/github-portfolio.js"><\/script> -->/<script src="assets\/js\/github-portfolio.js"><\/script>/' index.html
        sed -i 's/<!-- <script src="assets\/js\/static-portfolio.js"><\/script> -->/<script src="assets\/js\/static-portfolio.js"><\/script>/' index.html
        
        echo "✅ Hybrid mode configured!"
        echo "📝 Your GitHub projects will be fetched automatically"
        echo "⭐ You can also add featured projects manually"
        echo "💡 Uncomment the addFeaturedProject examples in github-portfolio.js"
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "=== Next Steps ==="
echo "1. 🖼️  Add project screenshots to your repositories or assets/images/projects/"
echo "2. 📝 Update project descriptions in your GitHub repos"
echo "3. 🏷️  Add relevant topics/tags to your GitHub repositories"
echo "4. 🌐 Test your portfolio by opening index.html in a browser"
echo "5. 📚 Read GITHUB_PORTFOLIO_SETUP.md for detailed configuration options"

echo ""
echo "🎉 Portfolio configuration complete!"
