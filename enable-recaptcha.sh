#!/bin/bash
# Enable reCAPTCHA v3 after setting up production keys

echo "🔧 Enabling reCAPTCHA v3 in your portfolio..."

# Check if site key is provided
if [ -z "$1" ]; then
    echo "❌ Error: Please provide your reCAPTCHA v3 site key"
    echo "Usage: ./enable-recaptcha.sh YOUR_V3_SITE_KEY_HERE"
    echo ""
    echo "Note: Make sure you created reCAPTCHA v3 keys (not v2)!"
    exit 1
fi

SITE_KEY="$1"

echo "📝 Updating HTML and JavaScript to use site key: $SITE_KEY"

# Update reCAPTCHA v3 script in HTML
sed -i "s/render=YOUR_SITE_KEY_HERE/render=$SITE_KEY/" index.html

# Update site key in JavaScript file
sed -i "s/const RECAPTCHA_SITE_KEY = 'YOUR_SITE_KEY_HERE';/const RECAPTCHA_SITE_KEY = '$SITE_KEY';/" assets/js/plugins/contact-recaptcha-v3.js

echo "✅ reCAPTCHA v3 enabled successfully!"
echo "📝 Next steps:"
echo "   1. Test the form on your live site"
echo "   2. Check browser console for reCAPTCHA logs"
echo "   3. Commit and push changes to GitHub"
echo "   4. Verify form submissions work in production"
echo ""
echo "🌐 Your site: https://techdeityspark.github.io/portfolio"
echo "💡 reCAPTCHA v3 is invisible - no checkbox for users!"
echo ""
echo "Note: Make sure you created reCAPTCHA v3 keys (not v2)!"
