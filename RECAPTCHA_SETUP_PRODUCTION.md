# reCAPTCHA v3 Production Setup Guide

## The Problem
The reCAPTCHA "Invalid key type" error occurs because:
1. The site key is a placeholder (not real)
2. Not registered for your domain (techdeityspark.github.io)
3. Wrong reCAPTCHA version (you want v3, not v2)

## Solution: Create Your Own reCAPTCHA v3 Keys

### Step 1: Go to Google reCAPTCHA Admin Console
1. Visit: https://www.google.com/recaptcha/admin/create
2. Sign in with your Google account

### Step 2: Register Your Site for reCAPTCHA v3
1. **Label**: Enter a descriptive name (e.g., "Portfolio Contact Form v3")
2. **reCAPTCHA type**: Select **reCAPTCHA v3** (Important: NOT v2!)
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
- **Site Key** (public, goes in HTML and JavaScript)
- **Secret Key** (private, for server-side validation)

### Step 4: Update Your Site Key
Replace the placeholder in TWO places:

**1. In index.html (line ~21):**
```html
<!-- CURRENT: -->
<script src="https://www.google.com/recaptcha/api.js?render=YOUR_SITE_KEY_HERE"></script>

<!-- REPLACE WITH: -->
<script src="https://www.google.com/recaptcha/api.js?render=6LcYourActualV3SiteKeyHere"></script>
```

**2. In assets/js/plugins/contact-recaptcha-v3.js (line ~17):**
```javascript
// CURRENT:
const RECAPTCHA_SITE_KEY = 'YOUR_SITE_KEY_HERE';

// REPLACE WITH:
const RECAPTCHA_SITE_KEY = '6LcYourActualV3SiteKeyHere';
```

### Step 5: Understanding reCAPTCHA v3
- **v3 is invisible** - no checkbox or widget for users
- **Runs automatically** in the background when form is submitted
- **Gives a score** (0.0 to 1.0) indicating likelihood of being human
- **Better user experience** - no interruption for legitimate users

### Step 6: Update Formspree (Optional but Recommended)
1. Log into your Formspree account
2. Go to your form settings
3. Add your reCAPTCHA v3 secret key to enable server-side validation

### Step 7: Test
1. Save and commit changes
2. Push to GitHub
3. Test on your live site: https://techdeityspark.github.io/portfolio
4. Check browser console for reCAPTCHA logs
5. Verify form submissions work

## reCAPTCHA v3 vs v2 Comparison

| Feature | v2 | v3 |
|---------|----|----|
| User Experience | Shows checkbox/challenge | Invisible |
| Integration | Simple widget | JavaScript API |
| Scoring | Pass/Fail | Score 0.0-1.0 |
| Bot Detection | Challenge-based | Behavior analysis |
| Site Key Format | Starts with `6Lc` | Starts with `6Lc` |

## Troubleshooting

### Common Issues:
- **"Invalid key type"**: Using v2 key with v3 implementation (or vice versa)
- **"Invalid domain"**: Domain not registered in reCAPTCHA admin
- **Console errors**: Check site key is correctly set in both files
- **No reCAPTCHA execution**: Check browser dev tools for JavaScript errors

### Quick Test:
Open browser console on your live site and check for:
```
🔒 reCAPTCHA v3 initialized for enhanced security
```

If you see warnings about site key, update the placeholder values.

## Production Checklist
- [ ] Created reCAPTCHA v3 keys (not v2!) for techdeityspark.github.io
- [ ] Updated site key in HTML script tag
- [ ] Updated site key in JavaScript file
- [ ] Added secret key to Formspree (optional)
- [ ] Tested on live GitHub Pages site
- [ ] Verified form submissions work end-to-end
- [ ] Checked browser console for successful reCAPTCHA execution
- [ ] No "Invalid key type" errors

## Security Notes
- **Never commit your secret key to GitHub** (it's for server-side validation only)
- The site key is public and safe to include in your code
- reCAPTCHA v3 provides better bot detection through behavioral analysis
- Monitor your reCAPTCHA admin console for abuse patterns and scores
