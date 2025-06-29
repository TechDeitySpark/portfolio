// Static Portfolio Configuration
// Alternative to GitHub API integration - manually configure your projects

const staticPortfolioProjects = [
    {
        name: "E-Commerce Platform",
        description: "Full-stack e-commerce solution with React frontend and Node.js backend, featuring secure payment processing and inventory management.",
        category: "Full Stack",
        image: "assets/images/projects/ecommerce-platform.png",
        demoUrl: "https://your-ecommerce-demo.com",
        repoUrl: "https://github.com/TechDeitySpark/ecommerce-platform",
        technologies: ["React", "Node.js", "MongoDB", "Stripe API"],
        stats: { stars: 15, forks: 8 },
        featured: true
    },
    {
        name: "Task Management App",
        description: "Collaborative task management application with real-time updates, drag-and-drop interface, and team collaboration features.",
        category: "Frontend",
        image: "assets/images/projects/task-manager.png",
        demoUrl: "https://your-taskmanager-demo.com",
        repoUrl: "https://github.com/TechDeitySpark/task-manager",
        technologies: ["Vue.js", "Firebase", "Vuetify"],
        stats: { stars: 23, forks: 12 }
    },
    {
        name: "Data Analytics Dashboard",
        description: "Interactive dashboard for data visualization and analytics with real-time charts, filters, and export capabilities.",
        category: "Data Science",
        image: "assets/images/projects/analytics-dashboard.png",
        demoUrl: "https://your-analytics-demo.com",
        repoUrl: "https://github.com/TechDeitySpark/analytics-dashboard",
        technologies: ["Python", "Django", "D3.js", "PostgreSQL"],
        stats: { stars: 31, forks: 19 }
    },
    {
        name: "Mobile Weather App",
        description: "Cross-platform mobile application providing detailed weather forecasts with location-based services and offline support.",
        category: "Mobile",
        image: "assets/images/projects/weather-app.png",
        demoUrl: "https://play.google.com/store/apps/details?id=com.yourapp",
        repoUrl: "https://github.com/TechDeitySpark/weather-app",
        technologies: ["React Native", "Redux", "Weather API"],
        stats: { stars: 45, forks: 22 }
    },
    {
        name: "AI Chat Assistant",
        description: "Intelligent chatbot using natural language processing with context awareness and multi-language support.",
        category: "Machine Learning",
        image: "assets/images/projects/ai-chatbot.png",
        demoUrl: "https://your-chatbot-demo.com",
        repoUrl: "https://github.com/TechDeitySpark/ai-chatbot",
        technologies: ["Python", "TensorFlow", "Flask", "OpenAI API"],
        stats: { stars: 67, forks: 34 }
    },
    {
        name: "Blockchain Voting System",
        description: "Secure and transparent voting system built on blockchain technology ensuring election integrity and voter privacy.",
        category: "Blockchain",
        image: "assets/images/projects/voting-system.png",
        demoUrl: "https://your-voting-demo.com",
        repoUrl: "https://github.com/TechDeitySpark/blockchain-voting",
        technologies: ["Solidity", "Web3.js", "Ethereum", "React"],
        stats: { stars: 89, forks: 41 }
    }
];

class StaticPortfolio {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.projects = staticPortfolioProjects;
    }

    generateProjectHTML(project, index) {
        const { name, description, category, image, demoUrl, repoUrl, technologies, stats, featured } = project;
        
        return `
            <div class="col-lg-6 col-md-6 col-sm-12">
                <div class="tmp-portfolio tmp-scroll-trigger tmp-fade-in animation-order-${index + 1} ${featured ? 'featured-project' : ''}" data-project="${name.toLowerCase().replace(/\s+/g, '-')}">
                    <div class="github-project-image">
                        <img src="${image}" alt="${name}" onerror="this.src='assets/images/latest-portfolio/github-placeholder.svg'">
                        <div class="project-overlay">
                            <div class="project-tech-stack">
                                ${technologies.map(tech => `<span class="tech-tag" data-lang="${tech}">${tech}</span>`).join('')}
                            </div>
                        </div>
                    </div>
                    <div class="portfolio-card-content-wrap">
                        <div class="content-left">
                            <p class="portfoli-card-para" data-category="${category}">${category}</p>
                            <h3 class="portfolio-card-title animated fadeIn">
                                <a href="${demoUrl}" target="_blank" rel="noopener noreferrer">
                                    ${name}
                                </a>
                            </h3>
                            <p class="project-description">${description}</p>
                            <div class="project-stats">
                                <span class="stat-item">
                                    <i class="fa-solid fa-star"></i> ${stats.stars}
                                </span>
                                <span class="stat-item">
                                    <i class="fa-solid fa-code-fork"></i> ${stats.forks}
                                </span>
                                <span class="stat-item primary-lang">${technologies[0]}</span>
                            </div>
                        </div>
                        <div class="portfolio-btn">
                            <div class="btn-group">
                                <a href="${demoUrl}" target="_blank" rel="noopener noreferrer" class="tmp-arrow-icon-btn" title="View Demo">
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

    renderProjects() {
        if (!this.container) {
            console.error('Portfolio container not found');
            return;
        }

        const projectsHTML = this.projects.map((project, index) => 
            this.generateProjectHTML(project, index)
        ).join('');
        
        const portfolioRow = this.container.querySelector('.row');
        if (portfolioRow) {
            portfolioRow.innerHTML = projectsHTML;
            
            // Trigger scroll animations for new content
            if (typeof tmpScrollTrigger !== 'undefined') {
                tmpScrollTrigger.refresh();
            }
        }
    }

    // Method to filter projects by category
    filterByCategory(category) {
        const filteredProjects = category === 'all' 
            ? staticPortfolioProjects 
            : staticPortfolioProjects.filter(project => project.category.toLowerCase() === category.toLowerCase());
        
        this.projects = filteredProjects;
        this.renderProjects();
    }

    // Method to add new project
    addProject(project) {
        staticPortfolioProjects.push(project);
        this.projects = staticPortfolioProjects;
        this.renderProjects();
    }
}

// Uncomment this section to use static portfolio instead of GitHub API
/*
document.addEventListener('DOMContentLoaded', function() {
    const staticPortfolio = new StaticPortfolio('portfolio');
    staticPortfolio.renderProjects();
    
    // Optional: Add category filtering
    // staticPortfolio.filterByCategory('Full Stack');
});
*/
