{*
 * Order Summary Page (Step 4)
 * Review order details before proceeding to checkout
 * Enhanced with order management and modification capabilities
 *
 * WHMCS Variables:
 * $products - Products in cart
 * $addons - Selected addons
 * $domains - Selected domains
 * $subtotal - Order subtotal
 * $total - Order total
 * $promotions - Applied promotions
 * $tax - Tax calculations
 * $currency - Currency information
 *}

{assign var="currentStep" value=4}
{assign var="pageTitle" value="Review Order"}
{assign var="bodyContent"}

<div id="orderSummaryPage">
    {* Page Header *}
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Review Your Order</h1>
        <p class="text-gray-400 text-lg">Please review your order details before proceeding to checkout</p>
    </div>
    
    {* Order Items Section *}
    <div class="space-y-8">
        
        {* Products Section *}
        {if $products}
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-semibold text-white flex items-center">
                        <svg class="w-6 h-6 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                        </svg>
                        Hosting Products
                    </h3>
                    <span class="text-sm text-gray-400">{count($products)} item{if count($products) != 1}s{/if}</span>
                </div>
                
                <div class="space-y-4">
                    {foreach from=$products item=product key=index}
                        <div class="border border-gray-600 rounded-lg p-4 bg-gray-800 hover:border-gray-500 transition-colors duration-200">
                            <div class="flex items-start justify-between">
                                <div class="flex-1">
                                    <div class="flex items-center space-x-3 mb-3">
                                        <div class="w-10 h-10 bg-ds-blue rounded-lg flex items-center justify-center">
                                            <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                                            </svg>
                                        </div>
                                        <div>
                                            <h4 class="text-lg font-medium text-white">{$product.name}</h4>
                                            {if $product.description}
                                                <p class="text-gray-400 text-sm">{$product.description|truncate:100}</p>
                                            {/if}
                                        </div>
                                    </div>
                                    
                                    {* Billing Cycle *}
                                    <div class="mb-3">
                                        <span class="inline-flex items-center px-3 py-1 bg-gray-700 text-gray-300 rounded-full text-sm">
                                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            {$product.billingcycle|capitalize}
                                            {if $product.billingcycle != "onetime"} Billing{/if}
                                        </span>
                                    </div>
                                    
                                    {* Configuration Options *}
                                    {if $product.configoptions}
                                        <div class="mb-3">
                                            <h5 class="text-sm font-medium text-gray-300 mb-2">Configuration:</h5>
                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
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
                                        <div class="mb-3">
                                            <h5 class="text-sm font-medium text-gray-300 mb-2">Add-ons:</h5>
                                            <div class="space-y-1">
                                                {foreach from=$product.addons item=addon}
                                                    <div class="flex justify-between text-sm">
                                                        <span class="text-gray-400">{$addon.name}</span>
                                                        <span class="text-ds-purple">
                                                            +{$selectedCurrency.prefix}{$addon.price}{$selectedCurrency.suffix}
                                                            {if $addon.cycle != "onetime"}
                                                                /{$addon.cycle}
                                                            {/if}
                                                        </span>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    {/if}
                                    
                                    {* Domain Assignment *}
                                    {if $product.domain}
                                        <div class="mb-3">
                                            <h5 class="text-sm font-medium text-gray-300 mb-1">Domain:</h5>
                                            <span class="text-ds-green text-sm font-medium">{$product.domain}</span>
                                        </div>
                                    {/if}
                                </div>
                                
                                {* Price and Actions *}
                                <div class="text-right ml-6">
                                    <div class="mb-3">
                                        <div class="text-xl font-bold text-ds-green">
                                            {$selectedCurrency.prefix}{$product.price}{$selectedCurrency.suffix}
                                        </div>
                                        {if $product.billingcycle != "onetime"}
                                            <div class="text-xs text-gray-400">/{$product.billingcycle}</div>
                                        {/if}
                                        {if $product.setupfee > 0}
                                            <div class="text-sm text-yellow-400 mt-1">
                                                +{$selectedCurrency.prefix}{$product.setupfee}{$selectedCurrency.suffix} setup
                                            </div>
                                        {/if}
                                    </div>
                                    
                                    {* Action Buttons *}
                                    <div class="space-y-2">
                                        <button type="button" 
                                                onclick="editProduct({$index})"
                                                class="w-full text-ds-blue hover:text-blue-400 text-sm underline transition-colors duration-200">
                                            Edit Configuration
                                        </button>
                                        <button type="button" 
                                                onclick="removeProduct({$index})"
                                                class="w-full text-red-400 hover:text-red-300 text-sm underline transition-colors duration-200">
                                            Remove
                                        </button>
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
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-semibold text-white flex items-center">
                        <svg class="w-6 h-6 text-ds-purple mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9"></path>
                        </svg>
                        Domain Services
                    </h3>
                    <span class="text-sm text-gray-400">{count($domains)} domain{if count($domains) != 1}s{/if}</span>
                </div>
                
                <div class="space-y-4">
                    {foreach from=$domains item=domain key=index}
                        <div class="border border-gray-600 rounded-lg p-4 bg-gray-800 hover:border-gray-500 transition-colors duration-200">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center space-x-3">
                                    <div class="w-10 h-10 bg-ds-purple rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9"></path>
                                        </svg>
                                    </div>
                                    <div>
                                        <h4 class="text-lg font-medium text-white">{$domain.name}</h4>
                                        <div class="flex items-center space-x-4 text-sm text-gray-400">
                                            <span class="capitalize">{$domain.type}</span>
                                            {if $domain.years > 1}
                                                <span>{$domain.years} years</span>
                                            {/if}
                                            {if $domain.type == "transfer" && $domain.authcode}
                                                <span class="text-ds-green">Auth code provided</span>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-right">
                                    <div class="text-lg font-bold text-ds-green">
                                        {$selectedCurrency.prefix}{$domain.price}{$selectedCurrency.suffix}
                                    </div>
                                    <div class="text-xs text-gray-400">/year</div>
                                    
                                    <div class="mt-2 space-x-3">
                                        <button type="button" 
                                                onclick="editDomain({$index})"
                                                class="text-ds-blue hover:text-blue-400 text-sm underline transition-colors duration-200">
                                            Edit
                                        </button>
                                        <button type="button" 
                                                onclick="removeDomain({$index})"
                                                class="text-red-400 hover:text-red-300 text-sm underline transition-colors duration-200">
                                            Remove
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
        
        {* Promotions Section *}
        {if $promotions}
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                    <svg class="w-6 h-6 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
                    </svg>
                    Applied Promotions
                </h3>
                
                <div class="space-y-3">
                    {foreach from=$promotions item=promo}
                        <div class="flex items-center justify-between p-3 bg-green-500/10 border border-green-500/20 rounded-lg">
                            <div class="flex items-center space-x-3">
                                <div class="w-8 h-8 bg-ds-green rounded-full flex items-center justify-center">
                                    <svg class="w-4 h-4 text-gray-900" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="font-medium text-green-300">{$promo.code}</h4>
                                    <p class="text-sm text-green-200">{$promo.description}</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <div class="text-lg font-bold text-green-300">
                                    -{$selectedCurrency.prefix}{$promo.discount}{$selectedCurrency.suffix}
                                </div>
                                <button type="button" 
                                        onclick="removePromotion('{$promo.code}')"
                                        class="text-green-400 hover:text-green-300 text-xs underline transition-colors duration-200">
                                    Remove
                                </button>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
        
        {* Add More Items Section *}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
            <h3 class="text-xl font-semibold text-white mb-4">Add More Items</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <a href="cart.php?a=view" 
                   class="flex items-center justify-center p-4 border border-gray-600 rounded-lg hover:border-ds-blue hover:bg-gray-800 transition-all duration-200">
                    <div class="text-center">
                        <svg class="w-8 h-8 text-ds-blue mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                        </svg>
                        <div class="text-sm font-medium text-white">More Products</div>
                        <div class="text-xs text-gray-400">Browse hosting plans</div>
                    </div>
                </a>
                
                <a href="cart.php?a=confdomains" 
                   class="flex items-center justify-center p-4 border border-gray-600 rounded-lg hover:border-ds-purple hover:bg-gray-800 transition-all duration-200">
                    <div class="text-center">
                        <svg class="w-8 h-8 text-ds-purple mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9"></path>
                        </svg>
                        <div class="text-sm font-medium text-white">More Domains</div>
                        <div class="text-xs text-gray-400">Register additional domains</div>
                    </div>
                </a>
                
                <div class="flex items-center justify-center p-4 border border-gray-600 rounded-lg cursor-pointer hover:border-ds-green hover:bg-gray-800 transition-all duration-200"
                     onclick="showPromoForm()">
                    <div class="text-center">
                        <svg class="w-8 h-8 text-ds-green mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
                        </svg>
                        <div class="text-sm font-medium text-white">Promo Code</div>
                        <div class="text-xs text-gray-400">Apply discount code</div>
                    </div>
                </div>
            </div>
        </div>
        
        {* Order Totals *}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
            <h3 class="text-xl font-semibold text-white mb-6">Order Totals</h3>
            
            <div class="space-y-3">
                {* Subtotal *}
                <div class="flex justify-between items-center text-lg">
                    <span class="text-gray-300">Subtotal:</span>
                    <span class="text-white font-medium">
                        {$selectedCurrency.prefix}{$subtotal|default:0}{$selectedCurrency.suffix}
                    </span>
                </div>
                
                {* Setup Fees *}
                {if $setupfees > 0}
                    <div class="flex justify-between items-center">
                        <span class="text-gray-300">Setup Fees:</span>
                        <span class="text-yellow-400 font-medium">
                            {$selectedCurrency.prefix}{$setupfees}{$selectedCurrency.suffix}
                        </span>
                    </div>
                {/if}
                
                {* Discounts *}
                {if $promotions}
                    <div class="flex justify-between items-center">
                        <span class="text-gray-300">Discount:</span>
                        <span class="text-ds-green font-medium">
                            -{$selectedCurrency.prefix}{$promotiondiscount|default:0}{$selectedCurrency.suffix}
                        </span>
                    </div>
                {/if}
                
                {* Tax *}
                {if $tax > 0}
                    <div class="flex justify-between items-center">
                        <span class="text-gray-300">Tax ({$taxrate}%):</span>
                        <span class="text-white font-medium">
                            {$selectedCurrency.prefix}{$tax}{$selectedCurrency.suffix}
                        </span>
                    </div>
                {/if}
                
                {* Total *}
                <div class="border-t border-gray-600 pt-4">
                    <div class="flex justify-between items-center">
                        <span class="text-2xl font-bold text-white">Total:</span>
                        <span class="text-3xl font-bold text-ds-green">
                            {$selectedCurrency.prefix}{$total|default:0}{$selectedCurrency.suffix}
                        </span>
                    </div>
                    {if $recurringtotal && $recurringtotal != $total}
                        <div class="text-sm text-gray-400 text-right mt-2">
                            Then {$selectedCurrency.prefix}{$recurringtotal}{$selectedCurrency.suffix} recurring
                        </div>
                    {/if}
                </div>
                
                {* Billing Period Info *}
                {if $products}
                    <div class="bg-blue-500/10 border border-blue-500/20 rounded-lg p-4 mt-4">
                        <div class="flex items-start">
                            <svg class="w-5 h-5 text-blue-400 mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <div class="text-sm">
                                <h5 class="font-medium text-blue-300 mb-1">Billing Information</h5>
                                <p class="text-blue-200">
                                    Your services will be automatically renewed according to your selected billing cycles.
                                    You can change or cancel these settings from your client area at any time.
                                </p>
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
        
        {* Empty Cart Message *}
        {if !$products && !$domains}
            <div class="text-center py-16">
                <div class="bg-gray-900 border border-gray-700 rounded-lg p-12 max-w-md mx-auto">
                    <div class="w-20 h-20 bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-6">
                        <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4m-2.4 0L3 3H1m6 10v6a2 2 0 002 2h8a2 2 0 002-2v-6m-8-2V7a4 4 0 118 0v4m-4 6v2"></path>
                        </svg>
                    </div>
                    <h3 class="text-2xl font-semibold text-white mb-3">Your Cart is Empty</h3>
                    <p class="text-gray-400 mb-6">Start building your online presence with our hosting solutions</p>
                    <a href="cart.php?a=view" 
                       class="inline-flex items-center px-6 py-3 btn-primary text-gray-900 rounded-lg font-bold transition-all duration-300 transform hover:scale-105">
                        Browse Products
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>
        {/if}
    </div>
    
    {* Promotion Code Modal *}
    <div id="promoModal" class="fixed inset-0 bg-gray-950/75 backdrop-blur-sm z-50 hidden items-center justify-center">
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 max-w-md w-full mx-4">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-lg font-semibold text-white">Apply Promotion Code</h3>
                <button type="button" 
                        onclick="hidePromoForm()"
                        class="text-gray-400 hover:text-gray-300 transition-colors duration-200">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <form id="promoCodeForm" onsubmit="return applyPromoCode(event)">
                <div class="mb-4">
                    <label for="promoCodeInput" class="block text-sm font-medium text-gray-300 mb-2">
                        Promotion Code
                    </label>
                    <input type="text" 
                           id="promoCodeInput" 
                           name="promocode"
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                           placeholder="Enter your promo code"
                           required>
                </div>
                
                <div class="flex space-x-3">
                    <button type="button" 
                            onclick="hidePromoForm()"
                            class="flex-1 bg-gray-700 hover:bg-gray-600 text-white py-3 px-4 rounded-lg font-medium transition-colors duration-200">
                        Cancel
                    </button>
                    <button type="submit" 
                            id="applyPromoBtn"
                            class="flex-1 bg-ds-green hover:bg-green-600 text-gray-900 py-3 px-4 rounded-lg font-bold transition-colors duration-200">
                        Apply Code
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    {* Navigation Buttons *}
    {if $products || $domains}
        <div class="flex justify-between items-center pt-8 border-t border-gray-700">
            <a href="cart.php?a=confdomains" 
               class="inline-flex items-center px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors duration-200">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                </svg>
                Back to Domains
            </a>
            
            <a href="cart.php?a=checkout" 
               class="inline-flex items-center px-8 py-3 btn-primary text-gray-900 rounded-lg font-bold transition-all duration-300 transform hover:scale-105">
                Proceed to Checkout
                <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                </svg>
            </a>
        </div>
    {/if}
</div>

{assign var="additionalFooter"}
<script>
    // Order summary functionality
    function editProduct(index) {
        // Redirect to product configuration with product index
        window.location.href = `cart.php?a=confproduct&i=${index}`;
    }
    
    function removeProduct(index) {
        if (confirm('Are you sure you want to remove this product from your cart?')) {
            OrderForm.showLoading('Removing product...');
            
            // Create form to remove product
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'cart.php';
            form.style.display = 'none';
            
            const actionInput = document.createElement('input');
            actionInput.name = 'a';
            actionInput.value = 'remove';
            
            const indexInput = document.createElement('input');
            indexInput.name = 'i';
            indexInput.value = index;
            
            const tokenInput = document.createElement('input');
            tokenInput.name = 'token';
            tokenInput.value = '{$token}';
            
            form.appendChild(actionInput);
            form.appendChild(indexInput);
            form.appendChild(tokenInput);
            document.body.appendChild(form);
            
            setTimeout(() => {
                form.submit();
            }, 500);
        }
    }
    
    function editDomain(index) {
        // Redirect to domain configuration
        window.location.href = `cart.php?a=confdomains&edit=${index}`;
    }
    
    function removeDomain(index) {
        if (confirm('Are you sure you want to remove this domain from your cart?')) {
            OrderForm.showLoading('Removing domain...');
            
            // Create form to remove domain
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'cart.php';
            form.style.display = 'none';
            
            const actionInput = document.createElement('input');
            actionInput.name = 'a';
            actionInput.value = 'removedomain';
            
            const indexInput = document.createElement('input');
            indexInput.name = 'i';
            indexInput.value = index;
            
            const tokenInput = document.createElement('input');
            tokenInput.name = 'token';
            tokenInput.value = '{$token}';
            
            form.appendChild(actionInput);
            form.appendChild(indexInput);
            form.appendChild(tokenInput);
            document.body.appendChild(form);
            
            setTimeout(() => {
                form.submit();
            }, 500);
        }
    }
    
    function removePromotion(code) {
        if (confirm('Are you sure you want to remove this promotion code?')) {
            OrderForm.showLoading('Removing promotion...');
            
            // Create form to remove promotion
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'cart.php';
            form.style.display = 'none';
            
            const actionInput = document.createElement('input');
            actionInput.name = 'a';
            actionInput.value = 'removepromo';
            
            const codeInput = document.createElement('input');
            codeInput.name = 'promocode';
            codeInput.value = code;
            
            const tokenInput = document.createElement('input');
            tokenInput.name = 'token';
            tokenInput.value = '{$token}';
            
            form.appendChild(actionInput);
            form.appendChild(codeInput);
            form.appendChild(tokenInput);
            document.body.appendChild(form);
            
            setTimeout(() => {
                form.submit();
            }, 500);
        }
    }
    
    function showPromoForm() {
        const modal = document.getElementById('promoModal');
        modal.classList.remove('hidden');
        modal.classList.add('flex');
        document.getElementById('promoCodeInput').focus();
        
        // Prevent body scroll
        document.body.style.overflow = 'hidden';
    }
    
    function hidePromoForm() {
        const modal = document.getElementById('promoModal');
        modal.classList.add('hidden');
        modal.classList.remove('flex');
        
        // Restore body scroll
        document.body.style.overflow = '';
        
        // Clear form
        document.getElementById('promoCodeInput').value = '';
    }
    
    function applyPromoCode(event) {
        event.preventDefault();
        
        const form = event.target;
        const codeInput = form.querySelector('#promoCodeInput');
        const submitBtn = form.querySelector('#applyPromoBtn');
        const code = codeInput.value.trim();
        
        if (!code) {
            OrderForm.showAlert('Please enter a promotion code.', 'error');
            codeInput.focus();
            return false;
        }
        
        // Show loading state
        OrderForm.showButtonLoading(submitBtn, 'Applying...');
        
        // Create form to apply promotion
        const promoForm = document.createElement('form');
        promoForm.method = 'POST';
        promoForm.action = 'cart.php';
        promoForm.style.display = 'none';
        
        const actionInput = document.createElement('input');
        actionInput.name = 'a';
        actionInput.value = 'validatepromo';
        
        const codeFormInput = document.createElement('input');
        codeFormInput.name = 'promocode';
        codeFormInput.value = code;
        
        const tokenInput = document.createElement('input');
        tokenInput.name = 'token';
        tokenInput.value = '{$token}';
        
        promoForm.appendChild(actionInput);
        promoForm.appendChild(codeFormInput);
        promoForm.appendChild(tokenInput);
        document.body.appendChild(promoForm);
        
        setTimeout(() => {
            promoForm.submit();
        }, 1000);
        
        return false;
    }
    
    // Initialize summary page
    document.addEventListener('DOMContentLoaded', function() {
        // Close modal when clicking outside
        document.getElementById('promoModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hidePromoForm();
            }
        });
        
        // Close modal with Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                hidePromoForm();
            }
        });
        
        // Add smooth scroll to navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
        
        // Auto-refresh cart summary periodically
        setInterval(function() {
            // In a real implementation, you might want to check for cart updates
            // and refresh the summary if needed
        }, 30000); // Check every 30 seconds
    });
</script>
{/assign}

{/assign}

{* Render the page using base layout *}
{include file="layouts/base.tpl" 
         pageTitle=$pageTitle 
         currentStep=$currentStep 
         bodyContent=$bodyContent 
         additionalFooter=$additionalFooter}