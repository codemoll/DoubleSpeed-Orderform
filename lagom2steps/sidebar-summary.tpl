{*
 * Sidebar Order Summary
 * Sticky sidebar component for order summary throughout the wizard
 * DoubleSpeedHost themed with cyber colors
 *
 * Variables:
 * $orderSummary - Array containing order details
 * $products - Array of selected products
 * $domain - Selected domain details
 * $subtotal - Order subtotal
 * $total - Order total
 * $currency - Currency symbol/code
 *}

<div class="sticky top-8">
    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 shadow-lg">
        {* Header *}
        <div class="flex items-center justify-between mb-6">
            <h3 class="text-xl font-bold text-white">Order Summary</h3>
            <div class="w-3 h-3 bg-green-400 rounded-full animate-pulse"></div>
        </div>
        
        {* Products Section *}
        {if $products}
            <div class="mb-6">
                <h4 class="text-sm font-semibold text-gray-300 uppercase tracking-wider mb-3 flex items-center">
                    <svg class="w-4 h-4 mr-2 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                    </svg>
                    Products
                </h4>
                <div class="space-y-3">
                    {foreach from=$products item=product}
                        <div class="flex justify-between items-start">
                            <div class="flex-1">
                                <div class="text-sm font-medium text-white">{$product.name}</div>
                                {if $product.cycle}
                                    <div class="text-xs text-gray-400">{$product.cycle}</div>
                                {/if}
                                {if $product.addons}
                                    <div class="mt-1 space-y-1">
                                        {foreach from=$product.addons item=addon}
                                            <div class="text-xs text-blue-300">+ {$addon.name}</div>
                                        {/foreach}
                                    </div>
                                {/if}
                            </div>
                            <div class="text-sm font-semibold text-green-400">
                                {$currency.prefix}{$product.price}{$currency.suffix}
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
        
        {* Domain Section *}
        {if $domain}
            <div class="mb-6">
                <h4 class="text-sm font-semibold text-gray-300 uppercase tracking-wider mb-3 flex items-center">
                    <svg class="w-4 h-4 mr-2 text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9m0 9c-5 0-9-4-9-9s4-9 9-9"></path>
                    </svg>
                    Domain
                </h4>
                <div class="flex justify-between items-center">
                    <div>
                        <div class="text-sm font-medium text-white">{$domain.name}</div>
                        <div class="text-xs text-gray-400">{$domain.period} registration</div>
                    </div>
                    <div class="text-sm font-semibold text-green-400">
                        {$currency.prefix}{$domain.price}{$currency.suffix}
                    </div>
                </div>
            </div>
        {/if}
        
        {* Promo Code Section *}
        <div class="mb-6">
            <div class="flex items-center space-x-2">
                <input type="text" 
                       name="promocode" 
                       placeholder="Promo Code" 
                       class="flex-1 bg-gray-800 border border-gray-600 rounded-md px-3 py-2 text-sm text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                <button type="button" 
                        class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors duration-200">
                    Apply
                </button>
            </div>
        </div>
        
        {* Totals Section *}
        <div class="border-t border-gray-700 pt-4 space-y-2">
            {if $subtotal}
                <div class="flex justify-between text-sm">
                    <span class="text-gray-400">Subtotal:</span>
                    <span class="text-white">{$currency.prefix}{$subtotal}{$currency.suffix}</span>
                </div>
            {/if}
            
            {if $orderSummary.discount}
                <div class="flex justify-between text-sm">
                    <span class="text-gray-400">Discount:</span>
                    <span class="text-green-400">-{$currency.prefix}{$orderSummary.discount}{$currency.suffix}</span>
                </div>
            {/if}
            
            {if $orderSummary.tax}
                <div class="flex justify-between text-sm">
                    <span class="text-gray-400">Tax:</span>
                    <span class="text-white">{$currency.prefix}{$orderSummary.tax}{$currency.suffix}</span>
                </div>
            {/if}
            
            <div class="border-t border-gray-600 pt-2 mt-3">
                <div class="flex justify-between items-center">
                    <span class="text-lg font-semibold text-white">Total:</span>
                    <span class="text-xl font-bold text-green-400">
                        {$currency.prefix}{$total|default:"0.00"}{$currency.suffix}
                    </span>
                </div>
            </div>
        </div>
        
        {* Security Badge *}
        <div class="mt-6 pt-4 border-t border-gray-700">
            <div class="flex items-center justify-center space-x-2 text-xs text-gray-400">
                <svg class="w-4 h-4 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                </svg>
                <span>Secure Checkout</span>
            </div>
        </div>
    </div>
</div>