﻿// GitHub Portfolio Integration
// This script fetches GitHub repositories and displays them in the portfolio section

class GitHubPortfolio {
    constructor(username, containerId) {
        this.username = username;
        this.container = document.getElementById(containerId);
        this.apiUrl = `https://api.github.com/users/${username}/repos`;
        this.projects = [];
    }

    async fetchRepositories() {
        try {
            const response = await fetch(`${this.apiUrl}?sort=updated&per_page=20`);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const repos = await response.json();
            
            // Filter out forks and focus on original repositories
            this.projects = repos
                .filter(repo => !repo.fork && !repo.archived)
                .sort((a, b) => new Date(b.updated_at) - new Date(a.updated_at))
                .slice(0, 12); // Limit to 12 projects for 4-column layout
            
            return this.projects;
        } catch (error) {
            console.error('Error fetching GitHub repositories:', error);
            return [];
        }
    }

    generateProjectHTML(repo, index) {
        const technologies = this.extractTechnologies(repo);
        const demoUrl = repo.homepage || repo.html_url;
        const repoUrl = repo.html_url;

        return `
            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="tmp-portfolio tmp-scroll-trigger tmp-fade-in animation-order-${index + 1}" data-repo-id="${repo.id}">
                    <div class="github-project-image">
                        <img src="${this.getProjectImage(repo)}" alt="${repo.name}" onerror="this.src='assets/images/latest-portfolio/github-placeholder.svg'">
                        <div class="project-overlay">
                            <div class="project-tech-stack">
                                ${technologies.map(tech => `<span class="tech-tag">${tech}</span>`).join('')}
                            </div>
                        </div>
                    </div>
                    <div class="portfolio-card-content-wrap">
                        <div class="content-left">
                            <h3 class="portfolio-card-title animated fadeIn">
                                <a href="${demoUrl}" target="_blank" rel="noopener noreferrer">
                                    ${this.formatProjectName(repo.name)}
                                </a>
                            </h3>
                            <p class="project-description">${repo.description || 'A showcase of innovative development work.'}</p>
                            <div class="project-stats">
                                <span class="stat-item">
                                    <i class="fa-solid fa-star"></i> ${repo.stargazers_count || 0}
                                </span>
                                <span class="stat-item">
                                    <i class="fa-solid fa-code-fork"></i> ${repo.forks_count || 0}
                                </span>
                                ${repo.language ? `<span class="stat-item primary-lang">${repo.language}</span>` : ''}
                            </div>
                        </div>
                        <div class="portfolio-btn">
                            <div class="btn-group">
                                <a href="${demoUrl}" target="_blank" rel="noopener noreferrer" class="tmp-arrow-icon-btn" title="View Project">
                                    <div class="btn-inner">
                                        <i class="tmp-icon fa-solid fa-external-link"></i>
                                        <i class="tmp-icon-bottom fa-solid fa-external-link"></i>
                                    </div>
                                </a>
                                <a href="${repoUrl}" target="_blank" rel="noopener noreferrer" class="tmp-arrow-icon-btn github-btn" title="View Code">
                                    <div class="btn-inner">
                                        <i class="tmp-icon fa-brands fa-github"></i>
                                        <i class="tmp-icon-bottom fa-brands fa-github"></i>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <a href="${demoUrl}" target="_blank" rel="noopener noreferrer" class="over_link"></a>
                </div>
            </div>
        `;
    }

    formatProjectName(name) {
        return name
            .replace(/[-_]/g, ' ')
            .replace(/\b\w/g, l => l.toUpperCase())
            .replace(/\b(API|UI|UX|AI|ML|DB|SQL|CSS|HTML|JS|TS)\b/gi, match => match.toUpperCase());
    }

    extractTechnologies(repo) {
        const technologies = [];
        
        // Add primary language
        if (repo.language) {
            technologies.push(repo.language);
        }
        
        // Add topics as technologies (GitHub topics are often used for tech stack)
        if (repo.topics && repo.topics.length > 0) {
            repo.topics.slice(0, 3).forEach(topic => {
                if (!technologies.includes(topic)) {
                    technologies.push(topic.charAt(0).toUpperCase() + topic.slice(1));
                }
            });
        }
        
        return technologies.slice(0, 4); // Limit to 4 technologies for display
    }

    getProjectImage(repo) {
        // Try to get a project screenshot from GitHub Pages or repository
        const possibleImages = [
            `https://raw.githubusercontent.com/${this.username}/${repo.name}/main/screenshot.png`,
            `https://raw.githubusercontent.com/${this.username}/${repo.name}/master/screenshot.png`,
            `https://raw.githubusercontent.com/${this.username}/${repo.name}/main/demo.png`,
            `https://raw.githubusercontent.com/${this.username}/${repo.name}/master/demo.png`,
            `https://raw.githubusercontent.com/${this.username}/${repo.name}/main/preview.png`,
            `https://raw.githubusercontent.com/${this.username}/${repo.name}/master/preview.png`
        ];
        
        // For now, return the first option - you can implement image checking logic
        return possibleImages[0];
    }

    async renderProjects() {
        console.log('GitHub Portfolio: renderProjects called');
        
        if (!this.container) {
            console.error('Portfolio container not found');
            return;
        }
        
        console.log('GitHub Portfolio: Container found, fetching repositories...');

        try {
            const repos = await this.fetchRepositories();
            console.log('GitHub Portfolio: Fetched', repos.length, 'repositories');
            
            if (repos.length === 0) {
                console.log('GitHub Portfolio: No repos found, using fallback');
                this.renderFallback();
                return;
            }

            const projectsHTML = repos.map((repo, index) => this.generateProjectHTML(repo, index)).join('');
            console.log('GitHub Portfolio: Generated HTML for', repos.length, 'projects');
            
            // Find the portfolio row and replace its content
            const portfolioRow = this.container.querySelector('.row');
            if (portfolioRow) {
                console.log('GitHub Portfolio: Replacing portfolio content...');
                portfolioRow.innerHTML = projectsHTML;
                
                // Trigger scroll animations for new content
                if (typeof tmpScrollTrigger !== 'undefined') {
                    tmpScrollTrigger.refresh();
                }
                console.log('GitHub Portfolio: Content replaced successfully');
            } else {
                console.error('GitHub Portfolio: .row element not found in container');
            }
        } catch (error) {
            console.error('Error rendering GitHub projects:', error);
            this.renderFallback();
        }
    }

    renderFallback() {
        // Keep original portfolio items if GitHub fetch fails
        console.log('Using fallback portfolio display');
    }

    // Method to manually add featured projects that aren't on GitHub
    addFeaturedProject(project) {
        const featuredHTML = `
            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="tmp-portfolio tmp-scroll-trigger tmp-fade-in animation-order-1 featured-project">
                    <img src="${project.image}" alt="${project.name}">
                    <div class="portfolio-card-content-wrap">
                        <div class="content-left">
                            <h3 class="portfolio-card-title animated fadeIn">
                                <a href="${project.url}" target="_blank" rel="noopener noreferrer">
                                    ${project.name}
                                </a>
                            </h3>
                            <p class="project-description">${project.description}</p>
                            <div class="project-tech-stack">
                                ${project.technologies.map(tech => `<span class="tech-tag">${tech}</span>`).join('')}
                            </div>
                        </div>
                        <div class="portfolio-btn">
                            <a href="${project.url}" target="_blank" rel="noopener noreferrer" class="tmp-arrow-icon-btn">
                                <div class="btn-inner">
                                    <i class="tmp-icon fa-solid fa-external-link"></i>
                                    <i class="tmp-icon-bottom fa-solid fa-external-link"></i>
                                </div>
                            </a>
                        </div>
                    </div>
                    <a href="${project.url}" target="_blank" rel="noopener noreferrer" class="over_link"></a>
                </div>
            </div>
        `;
        
        const portfolioRow = this.container.querySelector('.row');
        if (portfolioRow) {
            portfolioRow.insertAdjacentHTML('beforeend', featuredHTML);
        }
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    console.log('GitHub Portfolio: DOM loaded, initializing...');
    
    // Replace 'TechDeitySpark' with your GitHub username
    const githubPortfolio = new GitHubPortfolio('TechDeitySpark', 'portfolio');
    
    // Load GitHub projects
    console.log('GitHub Portfolio: Starting to render projects...');
    githubPortfolio.renderProjects();
    
    // Example of adding a featured project that's not on GitHub
    // githubPortfolio.addFeaturedProject({
    //     name: 'Enterprise System',
    //     description: 'Large-scale enterprise solution built for a major client.',
    //     category: 'Enterprise',
    //     image: 'assets/images/projects/enterprise-system.png',
    //     url: 'https://example.com/enterprise-demo',
    //     technologies: ['Java', 'Spring Boot', 'Oracle', 'Angular']
    // });
});

// Export for potential use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = GitHubPortfolio;
}

