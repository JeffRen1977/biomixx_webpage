// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
    const hamburger = document.querySelector('.hamburger');
    const navMenu = document.querySelector('.nav-menu');
    
    if (hamburger && navMenu) {
        hamburger.addEventListener('click', function() {
            hamburger.classList.toggle('active');
            navMenu.classList.toggle('active');
        });
        
        // Close menu when clicking on a link
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            });
        });
    }
    
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Form submission handling with FormSpree
    const demoForm = document.getElementById('demoForm');
    const newsletterForm = document.getElementById('newsletterForm');
    
    if (demoForm) {
        demoForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Simple validation
            let isValid = true;
            const requiredFields = this.querySelectorAll('[required]');
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = '#ef4444';
                } else {
                    field.style.borderColor = '#e5e7eb';
                }
            });
            
            if (isValid) {
                // Send to FormSpree
                const formData = new FormData(this);
                formData.append('_subject', 'New Demo Request from BiomixX Website');
                const formAction = 'https://formspree.io/f/xanlbqre';
                
                fetch(formAction, {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.ok) {
                        showMessage('Thank you for your submission! We will get back to you soon.', 'success');
                        this.reset();
                    } else {
                        throw new Error('Form submission failed');
                    }
                })
                .catch(error => {
                    showMessage('There was an error submitting your form. Please try again or contact us directly.', 'error');
                });
            } else {
                showMessage('Please fill in all required fields.', 'error');
            }
        });
    }
    
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Simple validation
            const emailField = this.querySelector('[type="email"]');
            if (!emailField.value.trim()) {
                showMessage('Please enter your email address.', 'error');
                return;
            }
            
            // SIMPLE METHOD: Send to FormSpree and manually add to mailing list
            // This sends you an email, and you can add subscribers to Mailchimp/etc manually
            const formData = new FormData(this);
            formData.append('_subject', 'Newsletter Subscription - BiomixX');
            formData.append('_template', 'plain');
            
            const formAction = 'https://formspree.io/f/xanlbqre';
            
            fetch(formAction, {
                method: 'POST',
                body: formData,
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.ok) {
                    showMessage('Thank you for subscribing! We will add you to our mailing list.', 'success');
                    this.reset();
                } else {
                    throw new Error('Subscription failed');
                }
            })
            .catch(error => {
                showMessage('There was an error. Please try again later.', 'error');
            });
            
            // OPTION 2: Use Mailchimp API (requires setup - see MAILING_LIST_SETUP.md)
            // Uncomment below and configure API credentials if you want automatic mailing list integration
            /*
            const MAILCHIMP_API_KEY = 'YOUR_MAILCHIMP_API_KEY';
            const MAILCHIMP_AUDIENCE_ID = 'YOUR_AUDIENCE_ID';
            const email = emailField.value.trim();
            const mailchimpUrl = `https://us2.api.mailchimp.com/3.0/lists/${MAILCHIMP_AUDIENCE_ID}/members`;
            
            fetch(mailchimpUrl, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${MAILCHIMP_API_KEY}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    email_address: email,
                    status: 'subscribed'
                })
            })
            .then(response => response.json())
            .then(data => {
                if (response.ok) {
                    showMessage('Thank you for subscribing!', 'success');
                    this.reset();
                } else if (data.title === 'Member Exists') {
                    showMessage('You are already subscribed!', 'success');
                    this.reset();
                }
            })
            .catch(error => {
                showMessage('Subscription failed. Please try again.', 'error');
            });
            */
        });
    }
    
    // Message display function
    function showMessage(text, type) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `message message-${type}`;
        messageDiv.textContent = text;
        messageDiv.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            z-index: 10000;
            animation: slideIn 0.3s ease;
            max-width: 400px;
        `;
        
        if (type === 'success') {
            messageDiv.style.backgroundColor = '#10b981';
        } else if (type === 'error') {
            messageDiv.style.backgroundColor = '#ef4444';
        }
        
        document.body.appendChild(messageDiv);
        
        // Remove message after 5 seconds
        setTimeout(() => {
            messageDiv.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => {
                document.body.removeChild(messageDiv);
            }, 300);
        }, 5000);
    }
    
    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
        
        .hamburger.active .bar:nth-child(2) {
            opacity: 0;
        }
        
        .hamburger.active .bar:nth-child(1) {
            transform: translateY(8px) rotate(45deg);
        }
        
        .hamburger.active .bar:nth-child(3) {
            transform: translateY(-8px) rotate(-45deg);
        }
    `;
    document.head.appendChild(style);
});

// Intersection Observer for animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe elements for animation
document.addEventListener('DOMContentLoaded', function() {
    const animatedElements = document.querySelectorAll('.problem-item, .benefit-item, .use-case-item, .feature-item, .process-step');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});
