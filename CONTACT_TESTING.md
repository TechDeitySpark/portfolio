# 🔧 Contact Form Testing & Setup Guide

## ✅ Current Status
- ✅ Formspree form ID configured: `mgvyrgez`
- ✅ Anti-spam protection enabled
- ✅ Input sanitization active
- ⚠️ reCAPTCHA temporarily disabled for testing

## 🚀 Quick Test (Without reCAPTCHA)

Your contact form should work now! Test it at:
https://techdeityspark.github.io/portfolio/

### Test Steps:
1. Fill out the contact form
2. Submit the message
3. Check if you receive an email at your registered address

## 🔐 Enable reCAPTCHA (Recommended)

### Step 1: Register your site
1. Go to: https://www.google.com/recaptcha/admin
2. Click "Create"
3. **Label**: Portfolio Contact Form
4. **Type**: reCAPTCHA v2 "I'm not a robot"
5. **Domains**: 
   - `techdeityspark.github.io`
   - `localhost` (for testing)

### Step 2: Get your keys
After registration, you'll get:
- **Site Key** (public) - goes in HTML
- **Secret Key** (private) - for server validation (not needed with Formspree)

### Step 3: Update HTML
Replace this line in `index.html`:
```html
<!-- <div class="g-recaptcha" data-sitekey="6LfYour_Site_Key_Here"></div> -->
```

With your actual site key:
```html
<div class="g-recaptcha" data-sitekey="YOUR_ACTUAL_SITE_KEY"></div>
```

### Step 4: Enable reCAPTCHA script
Uncomment this line in `<head>`:
```html
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
```

## 🛡️ Security Features Active

✅ **Honeypot Protection** - Hidden field catches bots
✅ **Rate Limiting** - Max 3 submissions per 5 minutes  
✅ **Input Sanitization** - Removes dangerous content
✅ **Spam Detection** - Blocks suspicious patterns
✅ **Email Validation** - Strict format checking
✅ **XSS Prevention** - Sanitizes all inputs

## 📧 Formspree Configuration

Your form is configured to send emails to the address associated with form ID `mgvyrgez`.

### Formspree Features:
- ✅ Automatic spam filtering
- ✅ Email notifications
- ✅ Form submission storage
- ✅ 50 submissions/month (free tier)

## 🔄 Deploy Changes

Commit and push your changes:
```bash
git add .
git commit -m "Fix contact form - temporarily disable reCAPTCHA for testing"
git push origin main
```

## 🧪 Testing Checklist

- [ ] Form loads without errors
- [ ] All fields accept input
- [ ] Validation messages work
- [ ] Form submits successfully
- [ ] Email confirmation received
- [ ] Security badge displays
- [ ] Mobile responsive

## 🚨 Troubleshooting

**Form not submitting?**
- Check browser console for errors
- Verify Formspree endpoint is correct
- Test with simple data first

**Not receiving emails?**
- Check spam folder
- Verify email address with Formspree
- Check Formspree dashboard for submissions

**reCAPTCHA errors?**
- Verify domain matches registration
- Check site key is correct
- Ensure script is loaded

## 📞 Alternative Contact Methods

Add these as backup in your portfolio:
- **Direct Email**: [amante739@gmail.com](mailto:amante739@gmail.com)
- **LinkedIn**: [Tamanna Rahman](https://www.linkedin.com/in/tamanna-rahman-diu/)
- **GitHub**: [TechDeitySpark](https://github.com/TechDeitySpark)

---

Your secure contact form is ready for testing! 🎉
