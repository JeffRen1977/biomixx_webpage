# Email Setup Guide for BiomixX Website

## Overview
Your website now has two forms that need email configuration:
1. **Demo Request Form** (on contact.html)
2. **Newsletter Subscription Form** (on contact.html)

## Option 1: FormSpree (Recommended - Free & Easy)

FormSpree is a free service that handles form submissions and sends emails.

### Steps:

1. **Sign up for FormSpree:**
   - Go to https://formspree.io/
   - Click "Get Started" and create a free account
   - You get 50 submissions/month for free

2. **Create a form endpoint:**
   - After logging in, click "New Form"
   - Enter form name: "BiomixX Demo Requests"
   - Copy the form URL (looks like: `https://formspree.io/f/xxxxxxxxxx`)

3. **Update script.js:**
   - Open `script.js`
   - Find the line: `const formAction = 'https://formspree.io/f/YOUR_FORM_ID';`
   - Replace `YOUR_FORM_ID` with your actual form ID
   - You'll need to update this in TWO places (for demo form and newsletter form)

4. **Configure email delivery:**
   - In FormSpree dashboard, go to "Settings"
   - Add your email address in "Email Notifications"
   - Choose which submissions you want to receive

## Option 2: EmailJS (Free Alternative)

Another free service that sends emails directly from the browser.

### Steps:

1. **Sign up for EmailJS:**
   - Go to https://www.emailjs.com/
   - Create a free account (100 emails/month)

2. **Set up Email Service:**
   - Connect your email provider (Gmail, Outlook, etc.)
   - Or use EmailJS's built-in service

3. **Create a template:**
   - Create email templates for demo requests and newsletter
   - Set up your email template variables

4. **Update script.js:**
   - Add EmailJS SDK
   - Use EmailJS send function instead of FormSpree

## Option 3: AWS SES (Scalable Solution)

For high volume or enterprise use, use AWS Simple Email Service.

### Steps:

1. **Set up AWS SES:**
   - Verify your domain or email
   - Create IAM user with SES permissions
   - Set up Lambda function to handle form submissions

2. **Backend Implementation:**
   - Create API endpoint to receive form data
   - Process and send emails via SES

## Recommended: FormSpree Setup

Here's the exact code you need to update in `script.js`:

```javascript
// For Demo Form
const formAction = 'https://formspree.io/f/your-form-id-here';

// For Newsletter Form  
const formAction = 'https://formspree.io/f/your-form-id-here';
```

### Additional Configuration Options

You can customize your FormSpree emails by adding hidden fields:

```html
<!-- Add to your form -->
<input type="hidden" name="_subject" value="New Demo Request from BiomixX Website">
<input type="hidden" name="_cc" value="team@biomixx.com">
<input type="hidden" name="_replyto" value="{{email}}">
```

## Testing

After setup:
1. Deploy your updated `script.js` to AWS S3
2. Fill out the demo form on your website
3. Check your email for the submission
4. Test the newsletter subscription form

## Troubleshooting

- **Forms not submitting:** Check browser console for errors
- **Not receiving emails:** Check spam folder, verify email in FormSpree
- **Rate limits:** Free FormSpree has 50 submissions/month limit

## Need Help?

If you need assistance setting this up, let me know and I can:
- Help you sign up for FormSpree
- Walk through the configuration
- Test the form submissions
- Set up additional email handling

