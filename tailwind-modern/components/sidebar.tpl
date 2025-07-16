{*
 * Sidebar Component
 * Order summary sidebar with real-time updates
 * Sticky positioning with responsive behavior
 *
 * Variables:
 * $cart - Cart information array
 * $products - Array of selected products
 * $domains - Array of selected domains
 * $addons - Array of selected addons
 * $subtotal - Order subtotal
 * $total - Order total
 * $currency - Currency information
 * $promotions - Applied promotions
 *}

<div class="sticky top-24">
    <div class="bg-gray-900 border border-gray-700 rounded-lg shadow-lg overflow-hidden">
        {* Header *}
        <div class="flex items-center justify-between p-6 border-b border-gray-700">
            <h3 class="text-xl font-bold text-white">Order Summary</h3>
            <div class="flex items-center space-x-2">
                <div class="w-3 h-3 bg-ds-green rounded-full animate-pulse-slow" aria-hidden="true"></div>
                <span class="text-sm text-gray-400">Live</span>
            </div>
        </div>
        
        {* Order contents *}
        <div class="p-6 space-y-6" id="order-summary-content">
            
            {* Products Section *}
            <div id="products-section" class="{if !$products && !$cart.products}hidden{/if}">
                <h4 class="text-sm font-semibold text-gray-300 uppercase tracking-wider mb-3 flex items-center">
                    <svg class="w-4 h-4 mr-2 text-ds-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                    </svg>
                    Products
                </h4>
                <div class="space-y-3" id="products-list">
                    {if $products}
                        {foreach from=$products item=product}
                            <div class="flex justify-between items-start p-3 bg-gray-800 rounded-lg border border-gray-600 hover:border-gray-500 transition-colors duration-200" data-product-id="{$product.id}">
                                <div class="flex-1">
                                    <div class="text-sm font-medium text-white">{$product.name}</div>
                                    {if $product.cycle}
                                        <div class="text-xs text-gray-400">{$product.cycle}</div>
                                    {/if}
                                    {if $product.domain}
                                        <div class="text-xs text-ds-blue">{$product.domain}</div>
                                    {/if}
                                    
                                    {* Configuration options *}
                                    {if $product.configoptions}
                                        <div class="mt-2 space-y-1">
                                            {foreach from=$product.configoptions item=option}
                                                <div class="text-xs text-gray-300">
                                                    <span class="text-gray-400">{$option.name}:</span> {$option.value}
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                    
                                    {* Addons *}
                                    {if $product.addons}
                                        <div class="mt-2 space-y-1">
                                            {foreach from=$product.addons item=addon}
                                                <div class="text-xs text-ds-purple flex justify-between">
                                                    <span>+ {$addon.name}</span>
                                                    <span>{$currency.prefix}{$addon.price}{$currency.suffix}</span>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="text-right ml-3">
                                    <div class="text-sm font-semibold text-ds-green">
                                        {$currency.prefix}{$product.price}{$currency.suffix}
                                    </div>
                                    {if $product.cycle && $product.cycle != "onetime"}
                                        <div class="text-xs text-gray-400">/{$product.cycle}</div>
                                    {/if}
                                    
                                    {* Remove button *}
                                    <button type="button" 
                                            onclick="OrderForm.removeProduct('{$product.id}')"
                                            class="mt-1 text-xs text-red-400 hover:text-red-300 transition-colors duration-200"
                                            aria-label="Remove {$product.name}">
                                        Remove
                                    </button>
                                </div>
                            </div>
                        {/foreach}
                    {else}
                        <div class="text-center py-4 text-gray-400 text-sm" id="no-products-message">
                            No products selected
                        </div>
                    {/if}
                </div>
            </div>
            
            {* Domains Section *}
            <div id="domains-section" class="{if !$domains && !$cart.domains}hidden{/if}">
                <h4 class="text-sm font-semibold text-gray-300 uppercase tracking-wider mb-3 flex items-center">
                    <svg class="w-4 h-4 mr-2 text-ds-purple" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9"></path>
                    </svg>
                    Domains
                </h4>
                <div class="space-y-3" id="domains-list">
                    {if $domains}
                        {foreach from=$domains item=domain}
                            <div class="flex justify-between items-start p-3 bg-gray-800 rounded-lg border border-gray-600 hover:border-gray-500 transition-colors duration-200" data-domain-id="{$domain.id}">
                                <div class="flex-1">
                                    <div class="text-sm font-medium text-white">{$domain.name}</div>
                                    <div class="text-xs text-gray-400">{$domain.type|capitalize}</div>
                                    {if $domain.years > 1}
                                        <div class="text-xs text-ds-blue">{$domain.years} years</div>
                                    {/if}
                                </div>
                                <div class="text-right ml-3">
                                    <div class="text-sm font-semibold text-ds-green">
                                        {$currency.prefix}{$domain.price}{$currency.suffix}
                                    </div>
                                    <div class="text-xs text-gray-400">/year</div>
                                    
                                    {* Remove button *}
                                    <button type="button" 
                                            onclick="OrderForm.removeDomain('{$domain.id}')"
                                            class="mt-1 text-xs text-red-400 hover:text-red-300 transition-colors duration-200"
                                            aria-label="Remove {$domain.name}">
                                        Remove
                                    </button>
                                </div>
                            </div>
                        {/foreach}
                    {else}
                        <div class="text-center py-4 text-gray-400 text-sm" id="no-domains-message">
                            No domains selected
                        </div>
                    {/if}
                </div>
            </div>
            
            {* Promotion Code Section *}
            <div class="border-t border-gray-700 pt-4">
                <div class="flex items-center justify-between mb-3">
                    <h4 class="text-sm font-semibold text-gray-300 uppercase tracking-wider flex items-center">
                        <svg class="w-4 h-4 mr-2 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
                        </svg>
                        Promo Code
                    </h4>
                    {if $promotions}
                        <span class="text-xs text-ds-green">Applied</span>
                    {/if}
                </div>
                
                <div id="promo-section">
                    {if $promotions}
                        {foreach from=$promotions item=promo}
                            <div class="p-3 bg-green-500/10 border border-green-500/20 rounded-lg mb-2">
                                <div class="flex justify-between items-center">
                                    <div>
                                        <div class="text-sm font-medium text-green-300">{$promo.code}</div>
                                        <div class="text-xs text-green-200">{$promo.description}</div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-sm font-semibold text-green-300">
                                            -{$currency.prefix}{$promo.discount}{$currency.suffix}
                                        </div>
                                        <button type="button" 
                                                onclick="OrderForm.removePromotion('{$promo.code}')"
                                                class="text-xs text-green-400 hover:text-green-300 transition-colors duration-200"
                                                aria-label="Remove promotion code">
                                            Remove
                                        </button>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    {else}
                        <form id="promo-form" class="space-y-2" onsubmit="return OrderForm.applyPromotion(event)">
                            <div class="flex space-x-2">
                                <input type="text" 
                                       id="promo-code" 
                                       name="promocode"
                                       placeholder="Enter promo code" 
                                       class="flex-1 bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-sm text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       aria-label="Promotion code">
                                <button type="submit" 
                                        class="bg-ds-blue hover:bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                                        id="apply-promo-btn">
                                    Apply
                                </button>
                            </div>
                            <div id="promo-feedback" class="text-xs" role="status" aria-live="polite"></div>
                        </form>
                    {/if}
                </div>
            </div>
            
            {* Order Totals *}
            <div class="border-t border-gray-700 pt-4 space-y-3" id="order-totals">
                {* Subtotal *}
                <div class="flex justify-between items-center text-sm">
                    <span class="text-gray-300">Subtotal:</span>
                    <span class="text-white font-medium" id="subtotal-amount">
                        {if $subtotal}{$currency.prefix}{$subtotal}{$currency.suffix}{else}$0.00{/if}
                    </span>
                </div>
                
                {* Discounts *}
                {if $promotions}
                    <div class="flex justify-between items-center text-sm">
                        <span class="text-gray-300">Discount:</span>
                        <span class="text-ds-green font-medium" id="discount-amount">
                            -{$currency.prefix}{$promotion_discount|default:0}{$currency.suffix}
                        </span>
                    </div>
                {/if}
                
                {* Tax *}
                {if $tax > 0}
                    <div class="flex justify-between items-center text-sm">
                        <span class="text-gray-300">Tax ({$taxrate}%):</span>
                        <span class="text-white font-medium" id="tax-amount">
                            {$currency.prefix}{$tax}{$currency.suffix}
                        </span>
                    </div>
                {/if}
                
                {* Setup fees *}
                {if $setup_fee > 0}
                    <div class="flex justify-between items-center text-sm">
                        <span class="text-gray-300">Setup Fee:</span>
                        <span class="text-white font-medium" id="setup-fee-amount">
                            {$currency.prefix}{$setup_fee}{$currency.suffix}
                        </span>
                    </div>
                {/if}
                
                {* Total *}
                <div class="border-t border-gray-600 pt-3">
                    <div class="flex justify-between items-center">
                        <span class="text-lg font-semibold text-white">Total:</span>
                        <span class="text-xl font-bold text-ds-green" id="total-amount">
                            {if $total}{$currency.prefix}{$total}{$currency.suffix}{else}$0.00{/if}
                        </span>
                    </div>
                    {if $recurring_total && $recurring_total != $total}
                        <div class="text-xs text-gray-400 text-right mt-1">
                            Then {$currency.prefix}{$recurring_total}{$currency.suffix} {$billing_cycle}
                        </div>
                    {/if}
                </div>
            </div>
            
            {* Empty cart message *}
            <div id="empty-cart-message" class="{if $products || $domains || $cart.products || $cart.domains}hidden{/if} text-center py-8">
                <div class="w-16 h-16 bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4m-2.4 0L3 3H1m6 10v6a2 2 0 002 2h8a2 2 0 002-2v-6m-8-2V7a4 4 0 118 0v4m-4 6v2"></path>
                    </svg>
                </div>
                <h4 class="text-lg font-medium text-white mb-2">Your cart is empty</h4>
                <p class="text-gray-400 text-sm">Add products or domains to get started</p>
            </div>
            
            {* Action buttons *}
            <div class="border-t border-gray-700 pt-4 space-y-3" id="action-buttons">
                {if $products || $domains || $cart.products || $cart.domains}
                    <button type="button" 
                            onclick="OrderForm.clearCart()" 
                            class="w-full bg-gray-700 hover:bg-gray-600 text-white py-2 px-4 rounded-lg text-sm font-medium transition-colors duration-200">
                        Clear Cart
                    </button>
                    
                    <button type="button" 
                            onclick="OrderForm.saveCart()" 
                            class="w-full bg-gray-700 hover:bg-gray-600 text-white py-2 px-4 rounded-lg text-sm font-medium transition-colors duration-200">
                        Save for Later
                    </button>
                {/if}
            </div>
        </div>
    </div>
    
    {* Mobile cart toggle (only visible on mobile) *}
    <div class="lg:hidden mt-4">
        <button type="button" 
                id="mobile-cart-toggle"
                class="w-full bg-gray-800 border border-gray-600 rounded-lg p-4 text-white text-center hover:bg-gray-700 transition-colors duration-200"
                aria-expanded="false"
                aria-controls="order-summary-content">
            <div class="flex items-center justify-between">
                <span class="font-medium">Order Summary</span>
                <div class="flex items-center space-x-2">
                    <span class="text-ds-green font-bold" id="mobile-total">
                        {if $total}{$currency.prefix}{$total}{$currency.suffix}{else}$0.00{/if}
                    </span>
                    <svg class="w-4 h-4 transform transition-transform duration-200" id="mobile-cart-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </div>
            </div>
        </button>
    </div>
</div>

<script>
    // Sidebar functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile cart toggle
        const mobileToggle = document.getElementById('mobile-cart-toggle');
        const orderContent = document.getElementById('order-summary-content');
        const mobileIcon = document.getElementById('mobile-cart-icon');
        
        if (mobileToggle && orderContent) {
            mobileToggle.addEventListener('click', function() {
                const isExpanded = mobileToggle.getAttribute('aria-expanded') === 'true';
                
                mobileToggle.setAttribute('aria-expanded', !isExpanded);
                
                if (isExpanded) {
                    orderContent.classList.add('hidden');
                    mobileIcon.classList.remove('rotate-180');
                } else {
                    orderContent.classList.remove('hidden');
                    mobileIcon.classList.add('rotate-180');
                }
            });
        }
        
        // Update cart count in header
        function updateCartCount() {
            const products = document.querySelectorAll('#products-list [data-product-id]');
            const domains = document.querySelectorAll('#domains-list [data-domain-id]');
            const count = products.length + domains.length;
            
            const cartCountElement = document.getElementById('cart-count');
            if (cartCountElement) {
                cartCountElement.textContent = count;
                cartCountElement.style.display = count > 0 ? 'flex' : 'none';
            }
        }
        
        // Initialize cart count
        updateCartCount();
        
        // Listen for cart updates
        document.addEventListener('cartUpdated', updateCartCount);
    });
</script>