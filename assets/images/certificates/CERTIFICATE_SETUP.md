# Certificate Images Setup Guide

## Adding Your HackerRank Certificate

To display your actual HackerRank certificate:

### Option 1: Certificate Image (Recommended)
1. Take a screenshot or download your HackerRank certificate from: https://www.hackerrank.com/certificates/9e91e58625b8
2. Save the certificate image as: `hackerrank-certificate.jpg` (for thumbnail)
3. Save a high-resolution version as: `hackerrank-certificate-full.jpg` (for modal view)
4. Place both files in this folder: `assets/images/certificates/`

### Option 2: PDF Certificate
1. If you have a PDF certificate:
   - Convert the PDF to JPG using online tools or image editing software
   - Follow the same naming convention as Option 1

### Image Requirements:
- **Thumbnail Image** (`hackerrank-certificate.jpg`):
  - Recommended size: 600x400 pixels
  - Format: JPG or PNG
  - File size: Under 200KB for fast loading

- **Full-size Image** (`hackerrank-certificate-full.jpg`):
  - Recommended size: 1200x800 pixels or larger
  - Format: JPG or PNG
  - File size: Under 1MB

### Alternative Setup:
If you can't provide image files, the current setup will automatically fall back to showing the HackerRank iframe when the image fails to load.

### Current Certificate Files Needed:
- `hackerrank-certificate.jpg` (thumbnail for the certificates grid)
- `hackerrank-certificate-full.jpg` (full-size for modal view)

### File Structure:
```
assets/images/certificates/
├── hackerrank-certificate.jpg          # Thumbnail image
├── hackerrank-certificate-full.jpg     # Full-size modal image
├── cert-1.jpg                         # AWS certificate (placeholder)
├── cert-2.jpg                         # Oracle certificate (placeholder)
├── cert-3.jpg                         # Docker certificate (placeholder)
├── cert-4.jpg                         # Scrum certificate (placeholder)
├── cert-5.jpg                         # JavaScript certificate (placeholder)
├── cert-6.jpg                         # System Design certificate (placeholder)
└── README.md                          # This file
```

### How it Works:
1. Click "View Certificate" on any certificate card
2. Opens a modal with the full-size certificate image
3. Provides a "View Original" button to visit the official certificate page
4. Falls back to iframe if image is not available

### Need Help?
If you need assistance with image conversion or have questions about the setup, please refer to the main project documentation.
