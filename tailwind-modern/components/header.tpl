{*
 * Header Component
 * Site header with branding and navigation
 * Includes responsive design and accessibility features
 *
 * Variables:
 * $companyname - Company name for branding
 * $currentStep - Current step for context
 *}

<header class="bg-gray-900 border-b border-gray-700 sticky top-0 z-40" role="banner">
    <div class="container mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            {* Brand logo and name *}
            <div class="flex items-center space-x-4">
                <a href="{$WEB_ROOT}" class="flex items-center space-x-3 text-white hover:text-ds-green transition-colors duration-200" aria-label="DoubleSpeedHost Home">
                    {* Logo placeholder - replace with actual logo *}
                    <div class="w-8 h-8 bg-gradient-to-r from-ds-green to-ds-blue rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-gray-900" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-lg font-bold">DoubleSpeedHost</h1>
                        <div class="text-xs text-gray-400 leading-none">Order Form</div>
                    </div>
                </a>
            </div>
            
            {* Navigation and actions *}
            <nav class="flex items-center space-x-6" role="navigation" aria-label="Main navigation">
                {* Security badge *}
                <div class="hidden md:flex items-center space-x-2 text-sm text-gray-400">
                    <svg class="w-4 h-4 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                    </svg>
                    <span>Secure Checkout</span>
                </div>
                
                {* Support link *}
                <a href="{$WEB_ROOT}/contact.php" 
                   class="hidden sm:flex items-center space-x-2 text-sm text-gray-300 hover:text-ds-blue transition-colors duration-200"
                   aria-label="Contact Support">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192L5.636 18.364M12 12h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Need Help?</span>
                </a>
                
                {* Cart icon with item count *}
                <div class="relative">
                    <button type="button" 
                            id="cart-toggle"
                            class="flex items-center space-x-2 text-gray-300 hover:text-ds-green transition-colors duration-200 p-2 rounded-lg hover:bg-gray-800"
                            aria-label="View cart"
                            aria-expanded="false"
                            aria-controls="cart-dropdown">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4m-2.4 0L3 3H1m6 10v6a2 2 0 002 2h8a2 2 0 002-2v-6m-8-2V7a4 4 0 118 0v4m-4 6v2"></path>
                        </svg>
                        <span class="hidden sm:inline text-sm">Cart</span>
                        {* Cart item count badge *}
                        <span id="cart-count" 
                              class="absolute -top-1 -right-1 bg-ds-green text-gray-900 text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center min-w-[20px] transition-all duration-200"
                              style="display: none;"
                              aria-label="Items in cart">0</span>
                    </button>
                    
                    {* Cart dropdown (hidden by default) *}
                    <div id="cart-dropdown" 
                         class="absolute right-0 mt-2 w-80 bg-gray-800 border border-gray-600 rounded-lg shadow-xl z-50 hidden"
                         aria-hidden="true">
                        <div class="p-4">
                            <h3 class="text-sm font-semibold text-white mb-3">Shopping Cart</h3>
                            <div id="cart-items" class="space-y-2 mb-4">
                                <div class="text-sm text-gray-400 text-center py-4">
                                    Your cart is empty
                                </div>
                            </div>
                            <div class="border-t border-gray-600 pt-3">
                                <div class="flex justify-between items-center text-sm">
                                    <span class="text-gray-300">Total:</span>
                                    <span id="cart-total" class="font-semibold text-ds-green">$0.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                {* Mobile menu button *}
                <button type="button" 
                        id="mobile-menu-toggle"
                        class="sm:hidden p-2 rounded-lg text-gray-300 hover:text-white hover:bg-gray-800 transition-colors duration-200"
                        aria-label="Toggle mobile menu"
                        aria-expanded="false"
                        aria-controls="mobile-menu">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
            </nav>
        </div>
        
        {* Mobile menu (hidden by default) *}
        <div id="mobile-menu" class="sm:hidden border-t border-gray-700 hidden" aria-hidden="true">
            <div class="py-4 space-y-3">
                <a href="{$WEB_ROOT}/contact.php" 
                   class="flex items-center space-x-2 text-gray-300 hover:text-ds-blue transition-colors duration-200 py-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192L5.636 18.364M12 12h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Need Help?</span>
                </a>
                <div class="flex items-center space-x-2 text-gray-400 py-2">
                    <svg class="w-4 h-4 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                    </svg>
                    <span class="text-sm">Secure Checkout</span>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    // Header functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile menu toggle
        const mobileMenuToggle = document.getElementById('mobile-menu-toggle');
        const mobileMenu = document.getElementById('mobile-menu');
        
        if (mobileMenuToggle && mobileMenu) {
            mobileMenuToggle.addEventListener('click', function() {
                const isExpanded = mobileMenuToggle.getAttribute('aria-expanded') === 'true';
                
                mobileMenuToggle.setAttribute('aria-expanded', !isExpanded);
                mobileMenu.setAttribute('aria-hidden', isExpanded);
                
                if (isExpanded) {
                    mobileMenu.classList.add('hidden');
                } else {
                    mobileMenu.classList.remove('hidden');
                }
            });
        }
        
        // Cart dropdown toggle
        const cartToggle = document.getElementById('cart-toggle');
        const cartDropdown = document.getElementById('cart-dropdown');
        
        if (cartToggle && cartDropdown) {
            cartToggle.addEventListener('click', function() {
                const isExpanded = cartToggle.getAttribute('aria-expanded') === 'true';
                
                cartToggle.setAttribute('aria-expanded', !isExpanded);
                cartDropdown.setAttribute('aria-hidden', isExpanded);
                
                if (isExpanded) {
                    cartDropdown.classList.add('hidden');
                } else {
                    cartDropdown.classList.remove('hidden');
                }
            });
            
            // Close cart dropdown when clicking outside
            document.addEventListener('click', function(e) {
                if (!cartToggle.contains(e.target) && !cartDropdown.contains(e.target)) {
                    cartToggle.setAttribute('aria-expanded', 'false');
                    cartDropdown.setAttribute('aria-hidden', 'true');
                    cartDropdown.classList.add('hidden');
                }
            });
        }
    });
</script>