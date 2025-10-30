# Local Testing Guide for BiomixX Website

Testing your website locally before deployment is crucial to ensure everything works correctly. Here are multiple methods to test your BiomixX website locally.

## Method 1: Python HTTP Server (Recommended)

### Python 3 (Most Common)

```bash
# Navigate to your website directory
cd /Users/jeffren/Documents/BioInfo/BioMind9/BioMixx_Webpage

# Start local server
python3 -m http.server 8000
```

### Python 2 (If Python 3 not available)

```bash
python -m SimpleHTTPServer 8000
```

### Access Your Website

Open your browser and go to:
```
http://localhost:8000
```

## Method 2: Node.js HTTP Server

### Install http-server globally

```bash
npm install -g http-server
```

### Start the server

```bash
# From your website directory
http-server -p 8000
```

### Alternative: npx (no installation needed)

```bash
npx http-server -p 8000
```

## Method 3: PHP Built-in Server

```bash
# If PHP is installed
php -S localhost:8000
```

## Method 4: Live Server (VS Code Extension)

### Install Live Server Extension

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Live Server"
4. Install by Ritwick Dey

### Start Live Server

1. Right-click on `index.html`
2. Select "Open with Live Server"
3. Your website opens at `http://127.0.0.1:5500`

## Method 5: Browser File Opening (Limited)

**Note**: This method has limitations and may not work properly due to CORS restrictions.

```bash
# Simply double-click index.html or open in browser
open index.html  # macOS
start index.html # Windows
```

## Testing Checklist

### ✅ Basic Functionality

1. **Home Page Loads**
   - [ ] Hero section displays correctly
   - [ ] Navigation works
   - [ ] All sections visible
   - [ ] Images/icons display

2. **Navigation Testing**
   - [ ] All menu links work
   - [ ] Mobile hamburger menu functions
   - [ ] Active page highlighting works

3. **Responsive Design**
   - [ ] Test on different screen sizes
   - [ ] Mobile layout looks good
   - [ ] Tablet layout works
   - [ ] Desktop layout optimal

### ✅ Interactive Elements

4. **Forms Testing**
   - [ ] Contact form displays correctly
   - [ ] Demo request form works
   - [ ] Schedule form functions
   - [ ] Form validation works
   - [ ] Required fields marked properly

5. **JavaScript Features**
   - [ ] Mobile menu toggle works
   - [ ] Smooth scrolling functions
   - [ ] Form submission handling
   - [ ] Animation effects work

### ✅ Content Verification

6. **All Pages Load**
   - [ ] Home page (`index.html`)
   - [ ] Platform page (`platform.html`)
   - [ ] Use Cases page (`use-cases.html`)
   - [ ] Technology page (`technology.html`)
   - [ ] About page (`about.html`)
   - [ ] Contact page (`contact.html`)
   - [ ] Investors page (`investors.html`)
   - [ ] Schedule page (`schedule.html`)

7. **Content Accuracy**
   - [ ] All text displays correctly
   - [ ] No broken links
   - [ ] Contact information accurate
   - [ ] All CTAs work

## Browser Testing

### Test in Multiple Browsers

```bash
# Start your local server first
python3 -m http.server 8000

# Then test in different browsers:
# - Chrome: http://localhost:8000
# - Firefox: http://localhost:8000
# - Safari: http://localhost:8000
# - Edge: http://localhost:8000
```

### Mobile Testing

1. **Chrome DevTools**
   - Press F12 or Ctrl+Shift+I
   - Click device toggle icon
   - Test different device sizes

2. **Real Mobile Device**
   - Find your computer's IP address
   - Access `http://YOUR_IP:8000` on mobile
   - Test touch interactions

## Performance Testing

### Google PageSpeed Insights

1. Test your local site: `http://localhost:8000`
2. Use Chrome DevTools Performance tab
3. Check Core Web Vitals

### Network Testing

```bash
# Test with different network conditions in Chrome DevTools
# - Slow 3G
# - Fast 3G
# - WiFi
```

## Common Issues & Solutions

### Issue: CSS Not Loading

**Problem**: Styles not applied
**Solution**: Check file paths in HTML
```html
<!-- Make sure this path is correct -->
<link rel="stylesheet" href="styles.css">
```

### Issue: JavaScript Not Working

**Problem**: Interactive features not functioning
**Solution**: Check browser console for errors
```bash
# Open browser console (F12) and look for errors
```

### Issue: Images Not Displaying

**Problem**: Images show as broken
**Solution**: Verify image file paths and existence

### Issue: Forms Not Submitting

**Problem**: Forms don't work (expected for local testing)
**Solution**: This is normal - forms need backend processing

## Advanced Local Testing

### Using Vercel CLI for Local Testing

```bash
# Install Vercel CLI
npm install -g vercel

# Test locally with Vercel
vercel dev
```

This simulates the Vercel environment locally.

### Using Docker (Advanced)

Create `Dockerfile`:
```dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Run:
```bash
docker build -t biomixx.netsite .
docker run -p 8080:80 biomixx.netsite
```

## Testing Script

Create a simple test script `test-local.sh`:

```bash
#!/bin/bash

echo "Starting BiomixX website local test..."

# Start Python server in background
python3 -m http.server 8000 &
SERVER_PID=$!

echo "Server started on http://localhost:8000"
echo "Server PID: $SERVER_PID"

# Wait for user input
echo "Press Enter to stop the server..."
read

# Stop server
kill $SERVER_PID
echo "Server stopped."
```

Make it executable:
```bash
chmod +x test-local.sh
./test-local.sh
```

## Quick Test Commands

```bash
# Start server
python3 -m http.server 8000

# Test in different browsers (macOS)
open -a "Google Chrome" http://localhost:8000
open -a "Firefox" http://localhost:8000
open -a "Safari" http://localhost:8000

# Test mobile view
open -a "Google Chrome" --args --user-agent="Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X)"
```

## Pre-Deployment Checklist

Before deploying to Vercel or AWS S3:

- [ ] All pages load locally
- [ ] Navigation works on all pages
- [ ] Mobile responsive design tested
- [ ] Forms display correctly (submission will be handled by backend)
- [ ] No console errors
- [ ] All images load
- [ ] CSS styling applied correctly
- [ ] JavaScript interactions work
- [ ] Cross-browser compatibility tested

## Troubleshooting

### Port Already in Use

```bash
# Find process using port 8000
lsof -i :8000

# Kill the process
kill -9 PID_NUMBER

# Or use different port
python3 -m http.server 8080
```

### Permission Denied

```bash
# Make sure you're in the correct directory
pwd
ls -la

# Check file permissions
chmod 644 *.html *.css *.js
```

Your BiomixX website is ready for local testing! Start with `python3 -m http.server 8000` and visit `http://localhost:8000` to see your website in action.
