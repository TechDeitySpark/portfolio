#!/bin/bash
# Deployment script for portfolio website

echo "🚀 Deploying portfolio website..."

# Add all changes
git add .

# Commit with timestamp
git commit -m "Update portfolio - $(date '+%Y-%m-%d %H:%M:%S')"

# Push to GitHub
git push origin main

echo "✅ Deployment complete!"
echo "🌐 Your site will be updated at: https://YOUR_USERNAME.github.io/YOUR_REPOSITORY_NAME"
