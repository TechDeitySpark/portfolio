#!/bin/bash
# Enable reCAPTCHA after setting up production keys

echo "🔧 Enabling reCAPTCHA in your portfolio..."

# Check if site key is provided
if [ -z "$1" ]; then
    echo "❌ Error: Please provide your reCAPTCHA site key"
    echo "Usage: ./enable-recaptcha.sh YOUR_SITE_KEY_HERE"
    exit 1
fi

SITE_KEY="$1"

echo "📝 Updating HTML to use site key: $SITE_KEY"

# Enable reCAPTCHA script
sed -i 's/<!-- <script src="https:\/\/www.google.com\/recaptcha\/api.js" async defer><\/script> -->/<script src="https:\/\/www.google.com\/recaptcha\/api.js" async defer><\/script>/' index.html

# Enable reCAPTCHA widget and update site key
sed -i "s/<!-- <div class=\"col-lg-12 mb-3\">/<div class=\"col-lg-12 mb-3\">/" index.html
sed -i "s/<div class=\"g-recaptcha\" data-sitekey=\"YOUR_ACTUAL_SITE_KEY_HERE\"><\/div>/<div class=\"g-recaptcha\" data-sitekey=\"$SITE_KEY\"><\/div>/" index.html
sed -i "s/<small class=\"text-muted\">🔒 Please complete the security check above<\/small>/<small class=\"text-muted\">🔒 Please complete the security check above<\/small>/" index.html
sed -i "s/<\/div> -->/<\/div>/" index.html

# Switch back to secure contact form with reCAPTCHA
sed -i 's/contact-temp-no-recaptcha.js/contact-secure.js/' index.html

echo "✅ reCAPTCHA enabled successfully!"
echo "📝 Next steps:"
echo "   1. Test the form on your live site"
echo "   2. Commit and push changes to GitHub"
echo "   3. Verify reCAPTCHA works in production"
echo ""
echo "🌐 Your site: https://techdeityspark.github.io/portfolio"
