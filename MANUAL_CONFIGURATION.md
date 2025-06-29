# Manual Portfolio Configuration Guide

If the automated scripts don't work for you, here's how to manually configure your portfolio:

## Current Status
Your portfolio is currently set up with **GitHub API Integration** mode, which automatically fetches your repositories from GitHub.

## Configuration Options

### Option 1: GitHub API Integration (Current Setup ✅)
**What it does:** Automatically fetches your latest repositories from GitHub and displays them as portfolio projects.

**Current username:** TechDeitySpark

**To change the GitHub username:**
1. Open `assets/js/github-portfolio.js`
2. Find this line: `const githubPortfolio = new GitHubPortfolio('TechDeitySpark', 'portfolio');`
3. Replace `TechDeitySpark` with your GitHub username
4. Save the file

### Option 2: Static Portfolio Configuration
**What it does:** Uses manually configured projects that you define in the JavaScript file.

**To switch to static mode:**
1. Open `index.html`
2. Find this line: `<script src="assets/js/github-portfolio.js"></script>`
3. Comment it out: `<!-- <script src="assets/js/github-portfolio.js"></script> -->`
4. Add this line after it: `<script src="assets/js/static-portfolio.js"></script>`
5. Open `assets/js/static-portfolio.js`
6. Scroll to the bottom and uncomment this section:
   ```javascript
   // Change this:
   /*
   document.addEventListener('DOMContentLoaded', function() {
       const staticPortfolio = new StaticPortfolio('portfolio');
       staticPortfolio.renderProjects();
   });
   */
   
   // To this:
   document.addEventListener('DOMContentLoaded', function() {
       const staticPortfolio = new StaticPortfolio('portfolio');
       staticPortfolio.renderProjects();
   });
   ```

### Option 3: Hybrid Mode
**What it does:** Uses both GitHub API projects AND manually featured projects.

**To enable hybrid mode:**
1. Ensure both scripts are enabled in `index.html`:
   ```html
   <script src="assets/js/github-portfolio.js"></script>
   <script src="assets/js/static-portfolio.js"></script>
   ```
2. In `assets/js/github-portfolio.js`, uncomment the `addFeaturedProject` examples
3. Configure your GitHub username as described in Option 1

## Customizing Your Projects

### For GitHub API Mode:
1. **Add project screenshots** to your GitHub repositories:
   - Add files named: `screenshot.png`, `demo.png`, or `preview.png` to the root of your repos
2. **Write good descriptions** for your repositories
3. **Add topics/tags** to your repositories for better categorization
4. **Set homepage URLs** in your repository settings for live demos

### For Static Mode:
1. **Edit the project list** in `assets/js/static-portfolio.js`
2. **Add project images** to `assets/images/projects/`
3. **Update project information** in the `staticPortfolioProjects` array

## Testing Your Configuration

1. **Open your portfolio** in a web browser: `index.html`
2. **Navigate to the "Work" section** (4th tab in the navigation)
3. **Check browser console** (Press F12, then click Console tab) for any errors
4. **Verify projects load correctly**

## Troubleshooting

### Projects not showing:
- Check browser console for JavaScript errors
- Verify your GitHub username is correct (for GitHub mode)
- Ensure repositories are public
- Check GitHub API rate limits (60/hour without authentication)

### Images not loading:
- Verify image files exist in your repositories (for GitHub mode)
- Check image paths in `assets/images/projects/` (for static mode)
- Ensure image files have correct names and extensions

### JavaScript errors:
- Ensure all script files exist
- Check for syntax errors in modified files
- Verify HTML script tags are correct

## Current File Status

### Active Scripts:
- ✅ `assets/js/github-portfolio.js` (GitHub API integration)
- ❌ `assets/js/static-portfolio.js` (Static configuration - disabled)

### Configuration Files:
- `assets/css/github-portfolio.css` - Styling for portfolio projects
- `GITHUB_PORTFOLIO_SETUP.md` - Detailed configuration documentation
- `configure-portfolio-simple.ps1` - Working PowerShell configuration script

## Need Help?

1. **Use the working script:** `.\configure-portfolio-simple.ps1`
2. **Check the detailed guide:** `GITHUB_PORTFOLIO_SETUP.md`
3. **Test in browser:** Open `index.html` and check the Work section
4. **Check console:** Press F12 in browser to see any JavaScript errors

Your portfolio is currently working with GitHub API integration! 🎉
