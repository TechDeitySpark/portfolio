/**
 * Secure Contact Form Handler with Anti-Spam Protection
 * Protects against spam, bots, phishing, and malicious attacks
 */

(function ($) {
    'use strict';

    var form = $('#contact-form');
    var formMessages = $('#form-messages');
    var submitBtn = $('#submit-btn');
    var submissionCount = 0;
    var lastSubmissionTime = 0;

    // Rate limiting: max 3 submissions per 5 minutes
    const MAX_SUBMISSIONS = 3;
    const TIME_WINDOW = 5 * 60 * 1000; // 5 minutes

    // Input sanitization - removes dangerous content
    function sanitizeInput(input) {
        return input.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
                   .replace(/[<>]/g, '')
                   .replace(/javascript:/gi, '')
                   .replace(/on\w+\s*=/gi, '')
                   .trim();
    }

    // Email validation
    function isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailRegex.test(email) && email.length <= 100;
    }

    // Phone validation (optional field)
    function isValidPhone(phone) {
        if (!phone) return true; // Optional field
        const phoneRegex = /^[\+]?[1-9][\d]{0,15}$/;
        return phoneRegex.test(phone.replace(/[\s\-\(\)]/g, ''));
    }

    // Check for suspicious/spam patterns
    function detectSuspiciousContent(text) {
        const suspiciousPatterns = [
            /https?:\/\/[^\s]+/gi, // URLs (except in email field)
            /\b(?:viagra|casino|loan|crypto|bitcoin|gambling|pharmacy|pills)\b/gi, // Spam keywords
            /<[^>]*>/g, // HTML tags
            /javascript:/gi, // JavaScript protocol
            /\b(?:select|union|insert|delete|drop|update|script)\b/gi, // SQL injection attempts
            /(.)\1{10,}/g, // Repeated characters (spam indicator)
            /[^\w\s@.\-\+\(\)]/g // Unusual characters
        ];
        
        return suspiciousPatterns.some(pattern => pattern.test(text));
    }

    // Rate limiting check
    function checkRateLimit() {
        const now = Date.now();
        
        if (now - lastSubmissionTime > TIME_WINDOW) {
            submissionCount = 0;
        }
        
        if (submissionCount >= MAX_SUBMISSIONS) {
            return false;
        }
        
        return true;
    }

    // Show styled messages
    function showMessage(message, type) {
        const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
        const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';
        
        formMessages.html(`
            <div class="alert ${alertClass} alert-dismissible fade show" role="alert">
                <i class="fa ${icon} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `).fadeIn();
        
        // Auto-hide success messages after 5 seconds
        if (type === 'success') {
            setTimeout(function() {
                formMessages.fadeOut();
            }, 5000);
        }
    }

    // Form submission handler
    $(form).submit(function (e) {
        e.preventDefault();

        // Clear previous messages
        formMessages.hide();

        // Rate limiting check
        if (!checkRateLimit()) {
            showMessage('Too many submissions detected. Please wait 5 minutes before trying again.', 'error');
            return;
        }

        // Get and sanitize form data
        var name = sanitizeInput($('#contact-name').val());
        var email = sanitizeInput($('input[name="email"]').val());
        var phone = sanitizeInput($('input[name="phone"]').val());
        var subject = sanitizeInput($('#subject').val());
        var message = sanitizeInput($('#contact-message').val());

        // Validation checks
        if (!name || name.length < 2) {
            showMessage('Please enter a valid name (at least 2 characters).', 'error');
            return;
        }

        if (!email || !isValidEmail(email)) {
            showMessage('Please enter a valid email address.', 'error');
            return;
        }

        if (!isValidPhone(phone)) {
            showMessage('Please enter a valid phone number or leave it empty.', 'error');
            return;
        }

        if (!subject || subject.length < 3) {
            showMessage('Please enter a subject (at least 3 characters).', 'error');
            return;
        }

        if (!message || message.length < 10) {
            showMessage('Please enter a message (at least 10 characters).', 'error');
            return;
        }

        // Check reCAPTCHA
        var recaptchaResponse = grecaptcha.getResponse();
        if (!recaptchaResponse) {
            showMessage('Please complete the reCAPTCHA verification.', 'error');
            return;
        }

        // Check for suspicious content
        var allContent = name + ' ' + subject + ' ' + message;
        if (detectSuspiciousContent(allContent)) {
            showMessage('Your message contains suspicious content. Please review and remove any links or unusual characters.', 'error');
            return;
        }

        // Check honeypot field (should be empty - catches bots)
        if ($('input[name="_gotcha"]').val()) {
            // Silent fail for bots
            showMessage('Thank you! Your message has been sent.', 'success');
            return;
        }

        // Disable submit button to prevent double submission
        submitBtn.prop('disabled', true).find('.btn-text').text('Sending...');

        // Prepare secure form data
        var formData = new FormData();
        formData.append('name', name);
        formData.append('email', email);
        formData.append('phone', phone);
        formData.append('subject', subject);
        formData.append('message', message);
        formData.append('g-recaptcha-response', recaptchaResponse);
        formData.append('_subject', `Portfolio Contact: ${subject}`);
        formData.append('_replyto', email);
        formData.append('_format', 'plain');

        // Submit form with security headers
        $.ajax({
            type: 'POST',
            url: $(form).attr('action'),
            data: formData,
            processData: false,
            contentType: false,
            timeout: 15000, // 15 second timeout
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
        .done(function (response) {
            showMessage('🎉 Thank you! Your message has been sent successfully. I\'ll get back to you soon!', 'success');
            form[0].reset();
            
            // Reset reCAPTCHA
            if (typeof grecaptcha !== 'undefined') {
                grecaptcha.reset();
            }
            
            // Update rate limiting
            submissionCount++;
            lastSubmissionTime = Date.now();
        })
        .fail(function (xhr, status, error) {
            var errorMessage = 'Oops! Something went wrong. Please try again later or contact me directly.';
            
            if (status === 'timeout') {
                errorMessage = 'Request timed out. Please check your internet connection and try again.';
            } else if (xhr.status === 422) {
                errorMessage = 'Please check your form data and try again.';
            } else if (xhr.status === 403) {
                errorMessage = 'Access denied. Please refresh the page and try again.';
            }
            
            showMessage(errorMessage, 'error');
        })
        .always(function() {
            // Re-enable submit button
            submitBtn.prop('disabled', false).find('.btn-text').text('Send Message');
        });
    });

    // Clear messages when user starts typing
    $('input, textarea').on('input', function() {
        if (formMessages.is(':visible')) {
            formMessages.fadeOut();
        }
    });

    // Additional security: Disable right-click on form (optional)
    // $(form).on('contextmenu', function(e) {
    //     e.preventDefault();
    // });

})(jQuery);
