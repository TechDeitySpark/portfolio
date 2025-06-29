# reCAPTCHA Production Setup Guide

## The Problem
The reCAPTCHA "Invalid key type" error occurs because the site key in your code is either:
1. A placeholder/test key (not real)
2. Not registered for your domain (techdeityspark.github.io)
3. Wrong key type (v2 vs v3 mismatch)

## Solution: Create Your Own reCAPTCHA Keys

### Step 1: Go to Google reCAPTCHA Admin Console
1. Visit: https://www.google.com/recaptcha/admin/create
2. Sign in with your Google account

### Step 2: Register Your Site
1. **Label**: Enter a descriptive name (e.g., "Portfolio Contact Form")
2. **reCAPTCHA type**: Select **reCAPTCHA v2** → **"I'm not a robot" Checkbox**
3. **Domains**: Add these domains (one per line):
   ```
   techdeityspark.github.io
   localhost
   127.0.0.1
   ```
   (This allows testing locally and production use)
4. **Owners**: Your Google account email
5. **Accept Terms**: Check the box
6. Click **Submit**

### Step 3: Get Your Keys
After registration, you'll get:
- **Site Key** (public, goes in HTML)
- **Secret Key** (private, for server-side validation)

### Step 4: Update Your HTML
Replace the placeholder site key in `index.html` line 1062:

**Current (placeholder):**
```html
<div class="g-recaptcha" data-sitekey="6LcEn3ErAAAAAF7mOHQCmSVwDsEAuy8OiOSyyPYz"></div>
```

**Replace with your real site key:**
```html
<div class="g-recaptcha" data-sitekey="YOUR_ACTUAL_SITE_KEY_HERE"></div>
```

### Step 5: Update Formspree (Optional but Recommended)
1. Log into your Formspree account
2. Go to your form settings
3. Add your reCAPTCHA secret key to enable server-side validation

### Step 6: Test
1. Save and commit changes
2. Push to GitHub
3. Test on your live site: https://techdeityspark.github.io/portfolio
4. Verify the reCAPTCHA widget loads and form submissions work

## Alternative: Disable reCAPTCHA Temporarily

If you want to launch immediately without reCAPTCHA, you can temporarily disable it:

1. Comment out the reCAPTCHA widget in HTML
2. Comment out reCAPTCHA validation in JavaScript
3. The form will still have honeypot, rate limiting, and content filtering

## Security Notes
- **Never commit your secret key to GitHub** (it's for server-side only)
- The site key is public and safe to include in your HTML
- Consider enabling additional reCAPTCHA security features in the admin console
- Monitor your reCAPTCHA analytics for abuse patterns

## Troubleshooting
- **"Invalid domain"**: Ensure your domain is registered correctly
- **Widget not loading**: Check for typos in the site key
- **Form still not working**: Verify Formspree endpoint is correct
- **CORS errors**: Ensure proper headers are set

## Production Checklist
- [ ] Created real reCAPTCHA keys for techdeityspark.github.io
- [ ] Updated site key in index.html
- [ ] Added secret key to Formspree (optional)
- [ ] Tested on live GitHub Pages site
- [ ] Verified form submissions work end-to-end
- [ ] Checked reCAPTCHA analytics for proper tracking
