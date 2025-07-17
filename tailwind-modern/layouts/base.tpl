{*
 * Base Layout Template
 * Foundation template for all order form pages
 * Provides consistent HTML structure, Tailwind CSS integration, and common components
 *
 * Variables:
 * $pageTitle - Page title for <title> tag
 * $currentStep - Current step number (1-5)
 * $bodyContent - Main page content
 * $additionalHead - Additional head content
 * $additionalFooter - Additional footer scripts
 *}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Professional web hosting and domain registration services">
    <meta name="robots" content="noindex, nofollow">
    
    <title>{if $pageTitle}{$pageTitle} - {/if}DoubleSpeedHost Order Form</title>
    
    {* Preconnect to external resources for performance *}
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    
    {* Tailwind CSS from CDN with custom configuration *}
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        // Tailwind CSS configuration with DoubleSpeed theme
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        // Brand colors
                        'ds-green': '#00ff88',
                        'ds-blue': '#0066ff',
                        'ds-purple': '#8800ff',
                        // Extended gray palette for dark theme
                        'gray-950': '#0a0a0a',
                        'gray-925': '#141414',
                        'gray-850': '#1f1f1f'
                    },
                    fontFamily: {
                        'sans': ['Inter', 'ui-sans-serif', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'Noto Sans', 'sans-serif'],
                        'mono': ['Fira Code', 'ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', 'Liberation Mono', 'Courier New', 'monospace']
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in-out',
                        'slide-up': 'slideUp 0.3s ease-out',
                        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                        'bounce-subtle': 'bounceSubtle 2s infinite'
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0', transform: 'translateY(10px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        slideUp: {
                            '0%': { opacity: '0', transform: 'translateY(20px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        bounceSubtle: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-5px)' }
                        }
                    }
                }
            }
        }
    </script>
    
    {* Custom CSS for additional styling *}
    <link rel="stylesheet" href="{$WEB_ROOT}/templates/orderforms/tailwind-modern/assets/styles.css">
    
    {* Google Fonts - Inter for modern typography *}
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    {* Favicon and touch icons *}
    <link rel="icon" type="image/x-icon" href="{$WEB_ROOT}/assets/img/favicon.ico">
    <link rel="apple-touch-icon" href="{$WEB_ROOT}/assets/img/apple-touch-icon.png">
    
    {* Additional head content from specific pages *}
    {if $additionalHead}{$additionalHead}{/if}
    
    {* Structured data for SEO *}
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "Organization",
        "name": "DoubleSpeedHost",
        "url": "{$WEB_ROOT}",
        "description": "Professional web hosting and domain registration services"
    }
    </script>
</head>

<body class="bg-gray-950 text-white min-h-screen font-sans antialiased">
    {* Skip to main content for accessibility *}
    <a href="#main-content" class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 bg-ds-blue text-white px-4 py-2 rounded-lg z-50">
        Skip to main content
    </a>
    
    {* Page header *}
    {include file="components/header.tpl"}
    
    {* Main content wrapper *}
    <main id="main-content" class="container mx-auto px-4 py-8" role="main">
        {* Global alert container for notifications *}
        <div id="alert-container" class="mb-6" aria-live="polite" aria-atomic="true">
            {include file="components/alerts.tpl"}
        </div>
        
        {* Progress indicator for multi-step process *}
        {if $currentStep}
            {include file="components/progress.tpl" currentStep=$currentStep}
        {/if}
        
        {* Main page content *}
        <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
            {* Main content area *}
            <div class="lg:col-span-3 animate-fade-in">
                {$bodyContent}
            </div>
            
            {* Sidebar with order summary *}
            <div class="lg:col-span-1">
                {include file="components/sidebar.tpl"}
            </div>
        </div>
    </main>
    
    {* Page footer *}
    {include file="components/footer.tpl"}
    
    {* Loading overlay for async operations *}
    {include file="components/loading.tpl"}
    
    {* Base JavaScript functionality *}
    <script src="{$WEB_ROOT}/templates/orderforms/tailwind-modern/assets/scripts.js"></script>
    
    {* Additional footer scripts from specific pages *}
    {if $additionalFooter}{$additionalFooter}{/if}
    
    {* Global error handling *}
    <script>
        // Global error handler for unhandled JavaScript errors
        window.addEventListener('error', function(e) {
            console.error('JavaScript error:', e.error);
            // Show user-friendly error message
            window.OrderForm.showAlert('An unexpected error occurred. Please refresh the page and try again.', 'error');
        });
        
        // Global handler for unhandled promise rejections
        window.addEventListener('unhandledrejection', function(e) {
            console.error('Unhandled promise rejection:', e.reason);
            window.OrderForm.showAlert('A network error occurred. Please check your connection and try again.', 'error');
        });
    </script>
</body>
</html>