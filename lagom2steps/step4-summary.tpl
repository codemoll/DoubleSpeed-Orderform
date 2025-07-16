{*
 * Step 4: Order Summary
 * Multi-step wizard - Order review and summary page
 * DoubleSpeedHost themed with Tailwind CSS
 *
 * WHMCS Variables:
 * $products - Products in cart
 * $addons - Selected addons
 * $domains - Selected domains
 * $subtotal - Order subtotal
 * $total - Order total
 * $promotions - Applied promotions
 * $clientdetails - Client information for review
 *}

{* Set current step for progress indicator *}
{assign var="currentStep" value=4}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Order - DoubleSpeedHost</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'ds-green': '#00ff88',
                        'ds-blue': '#0066ff', 
                        'ds-purple': '#8800ff'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-950 text-white min-h-screen">
    <div class="container mx-auto px-4 py-8">
        {* Include Progress Indicator *}
        {include file="order-progress.tpl" currentStep=$currentStep}
        
        <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
            {* Main Content *}
            <div class="lg:col-span-3">
                {* Page Header *}
                <div class="mb-8">
                    <h1 class="text-3xl font-bold text-white mb-2">Review Your Order</h1>
                    <p class="text-gray-400">Please review your order details before proceeding to checkout</p>
                </div>
                
                {* Order Items Section *}
                <div class="space-y-6">
                    
                    {* Products Section *}
                    {if $products}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                            <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                                <svg class="w-6 h-6 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                                </svg>
                                Hosting Products
                            </h3>
                            
                            <div class="space-y-4">
                                {foreach from=$products item=product}
                                    <div class="border border-gray-600 rounded-lg p-4 bg-gray-800">
                                        <div class="flex items-start justify-between">
                                            <div class="flex-1">
                                                <h4 class="text-lg font-medium text-white">{$product.name}</h4>
                                                <p class="text-gray-400 text-sm mt-1">{$product.description}</p>
                                                
                                                {* Product Configuration Details *}
                                                {if $product.configoptions}
                                                    <div class="mt-3">
                                                        <h5 class="text-sm font-medium text-gray-300 mb-2">Configuration:</h5>
                                                        <div class="space-y-1">
                                                            {foreach from=$product.configoptions item=option}
                                                                <div class="flex justify-between text-sm">
                                                                    <span class="text-gray-400">{$option.optionname}:</span>
                                                                    <span class="text-white">{$option.selectedvalue}</span>
                                                                </div>
                                                            {/foreach}
                                                        </div>
                                                    </div>
                                                {/if}
                                                
                                                {* Product Addons *}
                                                {if $product.addons}
                                                    <div class="mt-3">
                                                        <h5 class="text-sm font-medium text-gray-300 mb-2">Add-ons:</h5>
                                                        <div class="space-y-1">
                                                            {foreach from=$product.addons item=addon}
                                                                <div class="flex justify-between text-sm">
                                                                    <span class="text-gray-400">{$addon.name}</span>
                                                                    <span class="text-ds-green">
                                                                        +{$selectedCurrency.prefix}{$addon.price}{$selectedCurrency.suffix}/{$addon.cycle}
                                                                    </span>
                                                                </div>
                                                            {/foreach}
                                                        </div>
                                                    </div>
                                                {/if}
                                                
                                                <div class="mt-3 flex items-center text-sm">
                                                    <span class="text-gray-400">Billing Cycle:</span>
                                                    <span class="ml-2 px-2 py-1 bg-ds-blue text-white rounded text-xs font-medium">
                                                        {$product.billingcycle}
                                                    </span>
                                                </div>
                                            </div>
                                            
                                            <div class="ml-6 text-right">
                                                <div class="text-2xl font-bold text-ds-green">
                                                    {$selectedCurrency.prefix}{$product.price}{$selectedCurrency.suffix}
                                                </div>
                                                <div class="text-sm text-gray-400">
                                                    {if $product.setupfee > 0}
                                                        Setup: {$selectedCurrency.prefix}{$product.setupfee}{$selectedCurrency.suffix}
                                                    {else}
                                                        Free Setup
                                                    {/if}
                                                </div>
                                                <div class="mt-2">
                                                    <a href="cart.php?a=confproduct&i={$product.key}" 
                                                       class="text-ds-blue hover:text-blue-400 text-sm underline">
                                                        Edit Configuration
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Domains Section *}
                    {if $domains}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                            <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                                <svg class="w-6 h-6 text-ds-purple mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9m0 9c-5 0-9-4-9-9s4-9 9-9"></path>
                                </svg>
                                Domain Names
                            </h3>
                            
                            <div class="space-y-4">
                                {foreach from=$domains item=domain}
                                    <div class="border border-gray-600 rounded-lg p-4 bg-gray-800">
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center">
                                                <div class="w-3 h-3 rounded-full mr-3 
                                                    {if $domain.type == 'register'}bg-ds-green
                                                    {elseif $domain.type == 'transfer'}bg-ds-blue
                                                    {else}bg-ds-purple{/if}">
                                                </div>
                                                <div>
                                                    <h4 class="text-lg font-medium text-white">{$domain.domain}</h4>
                                                    <div class="flex items-center space-x-4 text-sm text-gray-400">
                                                        <span class="capitalize">{$domain.type}</span>
                                                        <span>{$domain.regperiod} year{if $domain.regperiod != 1}s{/if}</span>
                                                        {if $domain.type == 'transfer' && $domain.eppcode}
                                                            <span class="text-ds-green">EPP Code Provided</span>
                                                        {/if}
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="text-right">
                                                <div class="text-xl font-bold text-ds-green">
                                                    {$selectedCurrency.prefix}{$domain.price}{$selectedCurrency.suffix}
                                                </div>
                                                <div class="text-sm text-gray-400">
                                                    /{$domain.regperiod} year{if $domain.regperiod != 1}s{/if}
                                                </div>
                                                <div class="mt-1">
                                                    <a href="cart.php?a=confdomains" 
                                                       class="text-ds-blue hover:text-blue-400 text-sm underline">
                                                        Edit Domain
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Promotional Codes Section *}
                    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                        <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                            <svg class="w-6 h-6 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
                            </svg>
                            Promotional Code
                        </h3>
                        
                        {if $promotions}
                            <div class="space-y-2">
                                {foreach from=$promotions item=promo}
                                    <div class="flex items-center justify-between p-3 bg-green-900/30 border border-green-700 rounded-lg">
                                        <div class="flex items-center">
                                            <svg class="w-5 h-5 text-green-400 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <span class="text-green-300 font-medium">{$promo.code}</span>
                                            <span class="ml-2 text-green-200 text-sm">- {$promo.description}</span>
                                        </div>
                                        <div class="text-green-400 font-semibold">
                                            -{$selectedCurrency.prefix}{$promo.discount}{$selectedCurrency.suffix}
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        {else}
                            <form method="post" action="cart.php" class="flex space-x-3">
                                <input type="text" 
                                       name="promocode" 
                                       placeholder="Enter promotional code"
                                       class="flex-1 bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                <button type="submit" 
                                        name="a" 
                                        value="applycredit"
                                        class="bg-ds-blue hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                                    Apply Code
                                </button>
                            </form>
                        {/if}
                    </div>
                    
                    {* Order Totals Section *}
                    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                        <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                            <svg class="w-6 h-6 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z"></path>
                            </svg>
                            Order Totals
                        </h3>
                        
                        <div class="space-y-3">
                            <div class="flex justify-between text-lg">
                                <span class="text-gray-400">Subtotal:</span>
                                <span class="text-white">{$selectedCurrency.prefix}{$subtotal}{$selectedCurrency.suffix}</span>
                            </div>
                            
                            {if $setupfees > 0}
                                <div class="flex justify-between">
                                    <span class="text-gray-400">Setup Fees:</span>
                                    <span class="text-white">{$selectedCurrency.prefix}{$setupfees}{$selectedCurrency.suffix}</span>
                                </div>
                            {/if}
                            
                            {if $promotions}
                                <div class="flex justify-between">
                                    <span class="text-gray-400">Promotional Discount:</span>
                                    <span class="text-green-400">-{$selectedCurrency.prefix}{$promotiondiscount}{$selectedCurrency.suffix}</span>
                                </div>
                            {/if}
                            
                            {if $tax > 0}
                                <div class="flex justify-between">
                                    <span class="text-gray-400">Tax ({$taxrate}%):</span>
                                    <span class="text-white">{$selectedCurrency.prefix}{$tax}{$selectedCurrency.suffix}</span>
                                </div>
                            {/if}
                            
                            <div class="border-t border-gray-600 pt-3 mt-4">
                                <div class="flex justify-between items-center">
                                    <span class="text-2xl font-bold text-white">Total:</span>
                                    <span class="text-3xl font-bold text-ds-green">
                                        {$selectedCurrency.prefix}{$total}{$selectedCurrency.suffix}
                                    </span>
                                </div>
                                
                                {* Recurring information *}
                                {if $recurringtotal > 0}
                                    <div class="mt-2 text-sm text-gray-400 text-right">
                                        Then {$selectedCurrency.prefix}{$recurringtotal}{$selectedCurrency.suffix} {$recurringcycle}
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                    
                    {* Terms and Conditions *}
                    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                        <h3 class="text-xl font-semibold text-white mb-4">Terms and Conditions</h3>
                        
                        <div class="space-y-4">
                            <label class="flex items-start">
                                <input type="checkbox" 
                                       name="accepttos" 
                                       required
                                       class="mt-1 text-ds-blue focus:ring-ds-blue border-gray-600 bg-gray-800 rounded">
                                <span class="ml-3 text-gray-300">
                                    I have read and agree to the 
                                    <a href="/terms" target="_blank" class="text-ds-blue hover:text-blue-400 underline">Terms of Service</a>
                                    and 
                                    <a href="/privacy" target="_blank" class="text-ds-blue hover:text-blue-400 underline">Privacy Policy</a>
                                </span>
                            </label>
                            
                            <label class="flex items-start">
                                <input type="checkbox" 
                                       name="marketingemails"
                                       class="mt-1 text-ds-blue focus:ring-ds-blue border-gray-600 bg-gray-800 rounded">
                                <span class="ml-3 text-gray-300">
                                    I would like to receive promotional emails and updates about new services
                                </span>
                            </label>
                        </div>
                    </div>
                </div>
                
                {* Navigation Buttons *}
                <div class="flex justify-between mt-8">
                    <a href="cart.php?a=confdomains" 
                       class="bg-gray-700 hover:bg-gray-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                        ← Back to Domains
                    </a>
                    <button type="button" 
                            onclick="proceedToCheckout()"
                            class="bg-gradient-to-r from-ds-green to-ds-blue hover:from-ds-blue hover:to-ds-purple text-gray-900 font-bold px-8 py-3 rounded-lg transition-all duration-300 transform hover:scale-105">
                        Proceed to Checkout →
                    </button>
                </div>
            </div>
            
            {* Sidebar Summary *}
            <div class="lg:col-span-1">
                {include file="sidebar-summary.tpl" 
                         products=$cart.products 
                         domain=$cart.domain 
                         subtotal=$subtotal 
                         total=$total 
                         currency=$selectedCurrency}
            </div>
        </div>
    </div>
    
    <script>
        function proceedToCheckout() {
            // Validate terms acceptance
            const tosCheckbox = document.querySelector('input[name="accepttos"]');
            if (!tosCheckbox.checked) {
                alert('Please accept the Terms of Service to continue.');
                tosCheckbox.focus();
                return;
            }
            
            // Proceed to checkout
            window.location.href = 'cart.php?a=checkout';
        }
        
        // Auto-save form data
        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                localStorage.setItem('orderform_' + this.name, this.checked);
            });
            
            // Restore saved state
            const saved = localStorage.getItem('orderform_' + checkbox.name);
            if (saved === 'true') {
                checkbox.checked = true;
            }
        });
    </script>
</body>
</html>