# Certificate Setup Guide for assets/certificates/

## Current PDF Certificates Available:
- `rest_api_intermediate certificate.pdf` - REST API Intermediate
- `software_engineer certificate.pdf` - Software Engineer 
- `sql_basic certificate.pdf` - SQL Basic
- `sql_intermediate certificate.pdf` - SQL Intermediate

## Adding HackerRank Certificate:

### Option 1: Image Certificate (Recommended for web display)
1. Save your HackerRank certificate as: `hackerrank-certificate.jpg`
2. Place it in: `assets/certificates/`
3. Recommended size: 800x600 pixels
4. Format: JPG or PNG

### Option 2: PDF Certificate
1. Save your HackerRank certificate PDF as: `hackerrank-certificate.pdf`
2. Place it in: `assets/certificates/`
3. The modal will automatically display the PDF with an embedded viewer

### Option 3: Use Existing PDF
If you want to use one of your existing PDFs for the HackerRank certificate:
1. Choose which PDF represents your HackerRank certificate
2. Update the modal JavaScript in `index.html` to reference the correct PDF file

## How the Certificate Modal Works:

### Multiple Display Formats:
1. **Image View**: Shows certificate as image (fastest loading)
2. **PDF View**: Embedded PDF viewer in the modal
3. **Online View**: Shows the certificate via HackerRank's iframe

### Format Selection:
Users can switch between different formats using the format buttons in the modal:
- 🖼️ **Image**: Best for quick preview
- 📄 **PDF**: Full certificate with all details
- 🌐 **Online**: Direct from HackerRank (requires internet)

## Current Certificate Structure:
```
assets/certificates/
├── rest_api_intermediate certificate.pdf     # Your existing certificates
├── software_engineer certificate.pdf
├── sql_basic certificate.pdf
├── sql_intermediate certificate.pdf
├── hackerrank-certificate.jpg               # Add this for image view
├── hackerrank-certificate.pdf               # Add this for PDF view (optional)
└── SETUP.md                                 # This file
```

## Adding More Certificates:
To add any of your existing PDFs to the portfolio:
1. Update the certificates grid in `index.html`
2. Add a new certificate card
3. Update the modal JavaScript to handle the new certificate
4. The system supports both PDF and image formats

## Best Practices:
- **Images**: Use for thumbnails and quick previews (JPG/PNG, < 500KB)
- **PDFs**: Use for detailed certificate viewing (< 2MB for web performance)
- **File naming**: Use descriptive names without spaces (use hyphens or underscores)

## Need Help?
The current system is flexible and supports:
- ✅ PDF certificates (embedded viewer)
- ✅ Image certificates (JPG/PNG/SVG)
- ✅ Online certificate verification
- ✅ Mobile-responsive design
- ✅ Multiple format switching
