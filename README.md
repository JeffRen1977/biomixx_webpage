# BiomixX Website

A static website for BiomixX, an AI-powered bioinformatics platform for life sciences discovery. This website is designed to be deployed to AWS S3 for investor presentations and marketing purposes.

## Project Structure

```
BioMixx_Webpage/
├── index.html          # Home page
├── platform.html       # Platform overview
├── use-cases.html      # Use cases and applications
├── technology.html     # Technology and AI features
├── about.html          # About BiomixX
├── contact.html        # Contact and demo request
├── investors.html      # Investment opportunity
├── schedule.html       # Demo scheduling tool
├── styles.css          # Main stylesheet
├── script.js           # JavaScript functionality
└── README.md           # This file
```

## Pages Overview

### 1. Home Page (`index.html`)
- Hero section with main value proposition
- Problem statement highlighting the bottleneck in life sciences
- Solution overview showcasing BiomixX capabilities
- Key benefits and use cases preview
- Call-to-action sections

### 2. Platform Page (`platform.html`)
- How BiomixX works (3-step process)
- Core capabilities and features
- Comparison with traditional approaches
- Platform features and benefits

### 3. Use Cases Page (`use-cases.html`)
- Drug discovery applications
- Biomarker research
- Disease mechanism studies
- Clinical research
- Academic research
- Success stories and testimonials

### 4. Technology Page (`technology.html`)
- AI-powered knowledge integration
- Proteomics focus and multi-omics vision
- Technology stack details
- Built for scientists approach

### 5. About Page (`about.html`)
- Mission and vision
- Problem we solve
- Our approach and values
- Why BiomixX philosophy

### 6. Contact Page (`contact.html`)
- Demo request form
- Contact information
- Newsletter signup
- FAQ section

### 7. Investors Page (`investors.html`)
- Investment opportunity overview
- Market opportunity and metrics
- Competitive advantages
- Key metrics and value proposition

### 8. Schedule Page (`schedule.html`)
- Demo scheduling tool
- Preparation guidelines
- Alternative contact methods

## Features

- **Responsive Design**: Mobile-first approach with responsive layouts
- **Modern UI**: Clean, professional design with smooth animations
- **Interactive Forms**: Contact forms with validation
- **Navigation**: Fixed navigation with mobile hamburger menu
- **Accessibility**: Semantic HTML and proper contrast ratios
- **Performance**: Optimized CSS and JavaScript

## Deployment to AWS S3

### Prerequisites
- AWS CLI configured
- S3 bucket created
- Appropriate permissions set

### Deployment Steps

1. **Create S3 Bucket** (if not already created):
```bash
aws s3 mb s3://your-bucket-name
```

2. **Configure Bucket for Static Website Hosting**:
```bash
aws s3 website s3://your-bucket-name --index-document index.html --error-document index.html
```

3. **Upload Files**:
```bash
aws s3 sync . s3://your-bucket-name --exclude "*.md" --exclude ".git/*"
```

4. **Set Bucket Policy** (for public access):
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::your-bucket-name/*"
        }
    ]
}
```

5. **Access Your Website**:
Your website will be available at:
`http://your-bucket-name.s3-website-us-east-1.amazonaws.com`

### Alternative: CloudFront Distribution

For better performance and HTTPS support:

1. Create a CloudFront distribution
2. Set the S3 bucket as the origin
3. Configure custom domain (optional)
4. Enable HTTPS

## Customization

### Colors
The website uses a consistent color scheme defined in `styles.css`:
- Primary Blue: `#2563eb`
- Success Green: `#10b981`
- Error Red: `#ef4444`
- Text Gray: `#6b7280`

### Content
All content is contained within the HTML files and can be easily modified. The website uses semantic HTML structure for easy content updates.

### Forms
Forms are currently set up for client-side validation. For production use, integrate with:
- AWS Lambda for serverless form handling
- Third-party services like Formspree or Netlify Forms
- Your own backend API

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Performance

The website is optimized for fast loading:
- Minimal external dependencies (only Google Fonts)
- Optimized CSS with efficient selectors
- Lightweight JavaScript
- Compressed images (when added)

## Security Considerations

- Forms include basic client-side validation
- No sensitive data is stored client-side
- Consider implementing CSRF protection for production forms
- Use HTTPS in production (CloudFront recommended)

## Maintenance

- Regular content updates can be made directly to HTML files
- CSS changes should be tested across all pages
- JavaScript functionality is minimal and easy to maintain
- Consider implementing a CMS for non-technical content updates

## Contact

For questions about this website or BiomixX platform, please contact:
- Email: info@biomixx.com
- Demo requests: contact.html page
- Investment inquiries: investors.html page
