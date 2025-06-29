#!/bin/bash
# reCAPTCHA Setup Script for Portfolio Contact Form

echo "🔐 reCAPTCHA Setup for Portfolio Contact Form"
echo "=============================================="
echo ""

echo "📋 Follow these steps:"
echo ""
echo "1. Go to: https://www.google.com/recaptcha/admin/create"
echo ""
echo "2. Fill out the form:"
echo "   Label: Portfolio Contact Form"
echo "   Type: reCAPTCHA v2 → 'I'm not a robot' Checkbox"
echo "   Domains:"
echo "     - techdeityspark.github.io"
echo "     - localhost"
echo "     - 127.0.0.1"
echo ""
echo "3. After registration, copy your SITE KEY (starts with 6L...)"
echo ""

read -p "4. Enter your reCAPTCHA Site Key: " SITE_KEY

if [ -z "$SITE_KEY" ]; then
    echo "❌ No site key provided. Exiting..."
    exit 1
fi

echo ""
echo "🔧 Updating index.html with your site key..."

# Update the HTML file with the actual site key
sed -i "s/YOUR_SITE_KEY_HERE/$SITE_KEY/g" index.html

echo "✅ reCAPTCHA has been configured!"
echo ""
echo "🚀 Next steps:"
echo "   1. Test your form locally"
echo "   2. Commit and push changes:"
echo "      git add ."
echo "      git commit -m 'Enable reCAPTCHA for contact form'"
echo "      git push origin main"
echo ""
echo "🌐 Your secure contact form will be live at:"
echo "   https://techdeityspark.github.io/portfolio/"
echo ""
echo "🔒 Security features now active:"
echo "   ✅ reCAPTCHA bot protection"
echo "   ✅ Honeypot anti-spam"
echo "   ✅ Rate limiting"
echo "   ✅ Input sanitization"
echo "   ✅ Suspicious content detection"
