{*
 * Footer Component
 * Site footer with links, security information, and branding
 * Responsive design with mobile-optimized layout
 *}

<footer class="bg-gray-900 border-t border-gray-700 mt-16" role="contentinfo">
    <div class="container mx-auto px-4 py-8">
        {* Main footer content *}
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
            
            {* Company info *}
            <div class="space-y-4">
                <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-gradient-to-r from-ds-green to-ds-blue rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-gray-900" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold text-white">DoubleSpeedHost</h3>
                        <div class="text-xs text-gray-400">Premium Web Hosting</div>
                    </div>
                </div>
                <p class="text-sm text-gray-400 leading-relaxed">
                    Professional web hosting solutions with lightning-fast performance, 
                    24/7 support, and enterprise-grade security.
                </p>
                
                {* Social links *}
                <div class="flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-ds-blue transition-colors duration-200" aria-label="Follow us on Twitter">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84"></path>
                        </svg>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-ds-blue transition-colors duration-200" aria-label="Follow us on Facebook">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path fill-rule="evenodd" d="M20 10C20 4.477 15.523 0 10 0S0 4.477 0 10c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V10h2.54V7.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V10h2.773l-.443 2.89h-2.33v6.988C16.343 19.128 20 14.991 20 10z" clip-rule="evenodd"></path>
                        </svg>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-ds-blue transition-colors duration-200" aria-label="Connect with us on LinkedIn">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                        </svg>
                    </a>
                </div>
            </div>
            
            {* Quick links *}
            <div class="space-y-4">
                <h4 class="text-sm font-semibold text-white uppercase tracking-wider">Services</h4>
                <nav class="space-y-2" aria-label="Services">
                    <a href="{$WEB_ROOT}/web-hosting.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Web Hosting</a>
                    <a href="{$WEB_ROOT}/vps-hosting.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">VPS Hosting</a>
                    <a href="{$WEB_ROOT}/dedicated-servers.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Dedicated Servers</a>
                    <a href="{$WEB_ROOT}/domain-registration.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Domain Registration</a>
                    <a href="{$WEB_ROOT}/ssl-certificates.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">SSL Certificates</a>
                </nav>
            </div>
            
            {* Support links *}
            <div class="space-y-4">
                <h4 class="text-sm font-semibold text-white uppercase tracking-wider">Support</h4>
                <nav class="space-y-2" aria-label="Support">
                    <a href="{$WEB_ROOT}/contact.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Contact Us</a>
                    <a href="{$WEB_ROOT}/knowledgebase.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Knowledge Base</a>
                    <a href="{$WEB_ROOT}/submitticket.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Submit Ticket</a>
                    <a href="{$WEB_ROOT}/serverstatus.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Server Status</a>
                    <a href="{$WEB_ROOT}/announcements.php" class="block text-sm text-gray-400 hover:text-ds-green transition-colors duration-200">Announcements</a>
                </nav>
            </div>
            
            {* Security and trust *}
            <div class="space-y-4">
                <h4 class="text-sm font-semibold text-white uppercase tracking-wider">Security</h4>
                <div class="space-y-3">
                    {* Security badges *}
                    <div class="flex items-center space-x-2 text-sm text-gray-400">
                        <svg class="w-4 h-4 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                        <span>SSL Secured</span>
                    </div>
                    <div class="flex items-center space-x-2 text-sm text-gray-400">
                        <svg class="w-4 h-4 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                        <span>PCI Compliant</span>
                    </div>
                    <div class="flex items-center space-x-2 text-sm text-gray-400">
                        <svg class="w-4 h-4 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                        </svg>
                        <span>GDPR Compliant</span>
                    </div>
                    
                    {* Trust badges placeholder *}
                    <div class="pt-2 space-y-2">
                        <div class="text-xs text-gray-500 uppercase tracking-wider">Protected by</div>
                        <div class="flex space-x-2">
                            <div class="w-16 h-8 bg-gray-800 border border-gray-600 rounded flex items-center justify-center">
                                <span class="text-xs text-gray-400">SSL</span>
                            </div>
                            <div class="w-16 h-8 bg-gray-800 border border-gray-600 rounded flex items-center justify-center">
                                <span class="text-xs text-gray-400">PCI</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        {* Bottom footer *}
        <div class="border-t border-gray-700 pt-6">
            <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
                {* Copyright and legal *}
                <div class="text-center md:text-left">
                    <p class="text-sm text-gray-400">
                        © {$smarty.now|date_format:"%Y"} DoubleSpeedHost. All rights reserved.
                    </p>
                    <div class="mt-1 space-x-4">
                        <a href="{$WEB_ROOT}/privacy.php" class="text-xs text-gray-500 hover:text-ds-blue transition-colors duration-200">Privacy Policy</a>
                        <a href="{$WEB_ROOT}/terms.php" class="text-xs text-gray-500 hover:text-ds-blue transition-colors duration-200">Terms of Service</a>
                        <a href="{$WEB_ROOT}/acceptable-use.php" class="text-xs text-gray-500 hover:text-ds-blue transition-colors duration-200">Acceptable Use</a>
                    </div>
                </div>
                
                {* Payment methods *}
                <div class="text-center md:text-right">
                    <div class="text-xs text-gray-500 uppercase tracking-wider mb-2">We Accept</div>
                    <div class="flex justify-center md:justify-end space-x-2">
                        {* Payment method icons *}
                        <div class="w-8 h-5 bg-gray-800 border border-gray-600 rounded flex items-center justify-center">
                            <span class="text-xs text-gray-400">VISA</span>
                        </div>
                        <div class="w-8 h-5 bg-gray-800 border border-gray-600 rounded flex items-center justify-center">
                            <span class="text-xs text-gray-400">MC</span>
                        </div>
                        <div class="w-8 h-5 bg-gray-800 border border-gray-600 rounded flex items-center justify-center">
                            <span class="text-xs text-gray-400">PP</span>
                        </div>
                        <div class="w-8 h-5 bg-gray-800 border border-gray-600 rounded flex items-center justify-center">
                            <span class="text-xs text-gray-400">BTC</span>
                        </div>
                    </div>
                </div>
            </div>
            
            {* Additional footer info *}
            <div class="mt-4 pt-4 border-t border-gray-800 text-center">
                <p class="text-xs text-gray-500">
                    Order form powered by WHMCS | 
                    <span class="text-ds-green">99.9% Uptime Guarantee</span> | 
                    <span class="text-ds-blue">24/7 Expert Support</span>
                </p>
            </div>
        </div>
    </div>
    
    {* Back to top button *}
    <button type="button" 
            id="back-to-top" 
            class="fixed bottom-8 right-8 w-12 h-12 bg-ds-blue hover:bg-blue-600 text-white rounded-full shadow-lg opacity-0 invisible transition-all duration-300 transform hover:scale-110 z-30"
            aria-label="Back to top">
        <svg class="w-6 h-6 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
        </svg>
    </button>
</footer>

<script>
    // Footer functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Back to top button
        const backToTopButton = document.getElementById('back-to-top');
        
        if (backToTopButton) {
            // Show/hide button based on scroll position
            function toggleBackToTop() {
                if (window.pageYOffset > 300) {
                    backToTopButton.classList.remove('opacity-0', 'invisible');
                    backToTopButton.classList.add('opacity-100', 'visible');
                } else {
                    backToTopButton.classList.add('opacity-0', 'invisible');
                    backToTopButton.classList.remove('opacity-100', 'visible');
                }
            }
            
            // Listen for scroll events
            window.addEventListener('scroll', toggleBackToTop);
            
            // Handle click
            backToTopButton.addEventListener('click', function() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
            
            // Initial check
            toggleBackToTop();
        }
        
        // Add subtle animation to footer links
        const footerLinks = document.querySelectorAll('footer a');
        footerLinks.forEach(link => {
            link.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(4px)';
            });
            
            link.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });
    });
</script>