import { useState } from 'react'

function App() {
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  return (
    <div className="app">
      {/* Header */}
      <header className="header">
        <div className="container header-content">
          <a href="/" className="logo">
            <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
              <rect width="32" height="32" rx="8" fill="#3b82f6"/>
              <path d="M8 16L16 8L24 16L16 24L8 16Z" fill="white"/>
            </svg>
            <span>ModernSite</span>
          </a>
          
          <button 
            className="mobile-menu-btn"
            onClick={() => setIsMenuOpen(!isMenuOpen)}
            aria-label="Toggle menu"
          >
            <span className={`hamburger ${isMenuOpen ? 'open' : ''}`}></span>
          </button>

          <nav className={`nav ${isMenuOpen ? 'nav-open' : ''}`}>
            <a href="#features" className="nav-link">Features</a>
            <a href="#about" className="nav-link">About</a>
            <a href="#contact" className="nav-link">Contact</a>
            <a href="#cta" className="btn btn-primary">Get Started</a>
          </nav>
        </div>
      </header>

      {/* Hero Section */}
      <section className="hero">
        <div className="container hero-content">
          <div className="hero-text">
            <h1 className="hero-title">
              Build something <span className="gradient-text">amazing</span> today
            </h1>
            <p className="hero-description">
              A modern, fast, and responsive static site template. 
              Perfect for landing pages, portfolios, and small business websites.
            </p>
            <div className="hero-buttons">
              <a href="#cta" className="btn btn-primary btn-lg">Start Building</a>
              <a href="#features" className="btn btn-outline btn-lg">Learn More</a>
            </div>
          </div>
          <div className="hero-visual">
            <div className="hero-card">
              <div className="card-header">
                <span className="dot red"></span>
                <span className="dot yellow"></span>
                <span className="dot green"></span>
              </div>
              <div className="card-content">
                <div className="code-line"></div>
                <div className="code-line short"></div>
                <div className="code-line medium"></div>
                <div className="code-block">
                  <span className="keyword">const</span> <span className="variable">modern</span> = <span className="string">true</span>;
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="hero-bg"></div>
      </section>

      {/* Features Section */}
      <section id="features" className="features">
        <div className="container">
          <div className="section-header">
            <h2 className="section-title">Why choose us?</h2>
            <p className="section-description">
              Everything you need to create a stunning online presence
            </p>
          </div>
          <div className="features-grid">
            <div className="feature-card">
              <div className="feature-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/>
                </svg>
              </div>
              <h3 className="feature-title">Lightning Fast</h3>
              <p className="feature-description">
                Optimized for speed with instant page loads and smooth animations.
              </p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <rect x="2" y="3" width="20" height="14" rx="2"/>
                  <path d="M8 21h8M12 17v4"/>
                </svg>
              </div>
              <h3 className="feature-title">Fully Responsive</h3>
              <p className="feature-description">
                Looks perfect on every device from mobile to desktop.
              </p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M12 2L2 7l10 5 10-5-10-5z"/>
                  <path d="M2 17l10 5 10-5"/>
                  <path d="M2 12l10 5 10-5"/>
                </svg>
              </div>
              <h3 className="feature-title">Modern Stack</h3>
              <p className="feature-description">
                Built with the latest technologies for best performance.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section id="cta" className="cta">
        <div className="container">
          <div className="cta-content">
            <h2 className="cta-title">Ready to get started?</h2>
            <p className="cta-description">
              Join thousands of developers building amazing websites.
            </p>
            <a href="#contact" className="btn btn-primary btn-lg">Contact Us</a>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="footer">
        <div className="container">
          <div className="footer-content">
            <div className="footer-brand">
              <a href="/" className="logo">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <rect width="32" height="32" rx="8" fill="#3b82f6"/>
                  <path d="M8 16L16 8L24 16L16 24L8 16Z" fill="white"/>
                </svg>
                <span>ModernSite</span>
              </a>
              <p className="footer-tagline">Building the future, one page at a time.</p>
            </div>
            <div className="footer-links">
              <div className="footer-column">
                <h4>Product</h4>
                <a href="#features">Features</a>
                <a href="#pricing">Pricing</a>
                <a href="#docs">Docs</a>
              </div>
              <div className="footer-column">
                <h4>Company</h4>
                <a href="#about">About</a>
                <a href="#blog">Blog</a>
                <a href="#careers">Careers</a>
              </div>
              <div className="footer-column">
                <h4>Connect</h4>
                <a href="#twitter">Twitter</a>
                <a href="#github">GitHub</a>
                <a href="#discord">Discord</a>
              </div>
            </div>
          </div>
          <div className="footer-bottom">
            <p>&copy; 2026 ModernSite. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  )
}

export default App
