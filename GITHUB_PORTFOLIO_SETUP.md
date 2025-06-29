# GitHub Portfolio Configuration

This document explains how to configure and customize your GitHub portfolio integration.

## Configuration Options

### 1. Basic Setup

Edit the `assets/js/github-portfolio.js` file and update the initialization:

```javascript
// Replace 'TechDeitySpark' with your GitHub username
const githubPortfolio = new GitHubPortfolio('TechDeitySpark', 'portfolio');
```

### 2. Project Filtering

You can customize which repositories are shown by modifying the `fetchRepositories` method:

```javascript
// Current filter settings:
this.projects = repos
    .filter(repo => !repo.fork && !repo.archived)  // Hide forks and archived repos
    .sort((a, b) => new Date(b.updated_at) - new Date(a.updated_at))  // Sort by last updated
    .slice(0, 6); // Show only 6 projects
```

### 3. Featured Projects

Add non-GitHub projects or highlight specific projects:

```javascript
// Add after githubPortfolio.renderProjects();
githubPortfolio.addFeaturedProject({
    name: 'Enterprise System',
    description: 'Large-scale enterprise solution built for a major client.',
    category: 'Enterprise',
    image: 'assets/images/projects/enterprise-system.png',
    url: 'https://example.com/enterprise-demo',
    technologies: ['Java', 'Spring Boot', 'Oracle', 'Angular']
});
```

## Project Images

### Automatic Image Detection

The system tries to find project screenshots in this order:
1. `screenshot.png` in main/master branch
2. `demo.png` in main/master branch  
3. `preview.png` in main/master branch

### Adding Project Images

To add images to your GitHub repositories:

1. Create screenshots of your projects
2. Save them as `screenshot.png`, `demo.png`, or `preview.png`
3. Add them to the root of your repository
4. Commit and push to GitHub

### Local Project Images

For projects not on GitHub or custom images:

1. Add images to `assets/images/projects/`
2. Use the `addFeaturedProject` method as shown above

## Customization

### Repository Selection

To show only specific repositories, modify the filter:

```javascript
// Example: Show only repositories with specific topics
this.projects = repos
    .filter(repo => {
        return !repo.fork && 
               !repo.archived && 
               repo.topics && 
               repo.topics.includes('showcase'); // Only repos with 'showcase' topic
    })
    .slice(0, 6);
```

### Technology Display

The system automatically extracts technologies from:
- Repository primary language
- Repository topics/tags
- You can customize this in the `extractTechnologies` method

### Project Categories

Categories are determined by:
1. First repository topic (if available)
2. Primary programming language
3. Falls back to "Development"

## GitHub API Considerations

### Rate Limits
- GitHub API allows 60 requests per hour for unauthenticated requests
- For higher limits, consider adding authentication

### Authentication (Optional)

To increase API limits, add a GitHub token:

```javascript
async fetchRepositories() {
    const headers = {
        'Authorization': 'token YOUR_GITHUB_TOKEN'
    };
    
    const response = await fetch(`${this.apiUrl}?sort=updated&per_page=20`, { headers });
    // ... rest of the method
}
```

## Troubleshooting

### Projects Not Showing
1. Check browser console for errors
2. Ensure repositories are public
3. Verify GitHub username is correct
4. Check API rate limits

### Images Not Loading
1. Ensure image files exist in the repository
2. Check file names match expected patterns
3. Verify images are in main/master branch
4. Consider adding fallback images

### Styling Issues
1. Check CSS file is properly linked
2. Verify Bootstrap classes are available
3. Test responsive behavior on different screen sizes

## Static Alternative

If you prefer not to use the GitHub API, you can manually configure your projects:

```javascript
// Replace the githubPortfolio.renderProjects() call with:
const manualProjects = [
    {
        name: 'Your Project Name',
        description: 'Project description',
        category: 'Full Stack',
        image: 'assets/images/projects/project1.png',
        url: 'https://your-project-demo.com',
        repoUrl: 'https://github.com/yourusername/project',
        technologies: ['React', 'Node.js', 'MongoDB']
    },
    // Add more projects...
];

// Then render them manually or create a custom method
```

## Best Practices

1. **Repository Topics**: Use meaningful topics in your GitHub repositories
2. **README Files**: Ensure repositories have good README files
3. **Project Descriptions**: Write clear, concise descriptions
4. **Screenshots**: Add high-quality project screenshots
5. **Live Demos**: Deploy projects and add homepage URLs
6. **Regular Updates**: Keep repositories active and updated

## Examples

### Example Repository Setup
```
your-project/
├── README.md
├── screenshot.png    # Main project image
├── demo.png         # Alternative image
├── src/
└── ...
```

### Example Repository Topics
Add these topics to your repositories for better categorization:
- `showcase` - Mark as portfolio project
- `full-stack`, `frontend`, `backend` - Project type
- `react`, `nodejs`, `python` - Technologies used
- `web-app`, `mobile-app`, `desktop-app` - Application type
