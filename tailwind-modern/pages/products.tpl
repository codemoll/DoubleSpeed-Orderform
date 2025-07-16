{*
 * Products Selection Page (Step 1)
 * Modern product selection with enhanced UX and error handling
 * Full WHMCS integration with comprehensive accessibility
 *
 * WHMCS Variables:
 * $productgroups - Available product groups/categories
 * $products - Products in selected group
 * $currencies - Available currencies
 * $selectedCurrency - Currently selected currency
 * $gid - Selected group ID
 * $cartitems - Items already in cart
 *}

{assign var="currentStep" value=1}
{assign var="pageTitle" value="Select Products"}
{assign var="bodyContent"}

<form method="post" action="cart.php" id="productSelectionForm" novalidate>
    <input type="hidden" name="a" value="add">
    <input type="hidden" name="token" value="{$token}">
    
    {* Page Header *}
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Select Your Products</h1>
        <p class="text-gray-400 text-lg">Choose from our high-performance hosting solutions designed for speed and reliability</p>
    </div>
    
    {* Currency Selector *}
    {if $currencies && count($currencies) > 1}
        <div class="mb-8">
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-4">
                <div class="flex items-center justify-between">
                    <label for="currency-selector" class="text-sm font-medium text-gray-300">
                        Currency:
                    </label>
                    <select name="currency" 
                            id="currency-selector"
                            onchange="window.location.href='{$WEB_ROOT}/cart.php?gid={$gid}&currency=' + this.value"
                            class="bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                        {foreach from=$currencies item=currency}
                            <option value="{$currency.id}" {if $currency.id == $selectedCurrency.id}selected{/if}>
                                {$currency.code} ({$currency.prefix}{$currency.suffix})
                            </option>
                        {/foreach}
                    </select>
                </div>
            </div>
        </div>
    {/if}
    
    {* Product Groups Navigation *}
    {if $productgroups}
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-white mb-4">Product Categories</h2>
            <nav class="flex flex-wrap gap-3" role="navigation" aria-label="Product categories">
                {foreach from=$productgroups item=group}
                    <a href="?gid={$group.gid}" 
                       class="group px-6 py-3 rounded-lg border transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950
                              {if $group.gid == $gid}
                                  bg-ds-blue border-ds-blue text-white shadow-lg shadow-ds-blue/25
                              {else}
                                  bg-gray-800 border-gray-600 text-gray-300 hover:bg-gray-700 hover:border-ds-blue hover:text-white
                              {/if}"
                       aria-current="{if $group.gid == $gid}page{else}false{/if}">
                        <div class="flex items-center space-x-2">
                            <svg class="w-5 h-5 {if $group.gid == $gid}text-white{else}text-gray-400 group-hover:text-ds-blue{/if} transition-colors duration-200" 
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                            </svg>
                            <span class="font-medium">{$group.name}</span>
                            {if $group.productcount}
                                <span class="text-xs px-2 py-1 rounded-full bg-gray-700 text-gray-300">
                                    {$group.productcount}
                                </span>
                            {/if}
                        </div>
                        {if $group.description}
                            <div class="text-sm text-gray-400 mt-1 group-hover:text-gray-300 transition-colors duration-200">
                                {$group.description}
                            </div>
                        {/if}
                    </a>
                {/foreach}
            </nav>
        </div>
    {/if}
    
    {* Products Grid *}
    {if $products}
        <div class="mb-8">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-semibold text-white">Available Products</h2>
                <div class="text-sm text-gray-400">
                    {count($products)} product{if count($products) != 1}s{/if} available
                </div>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6" id="products-grid">
                {foreach from=$products item=product}
                    <div class="enhanced-card rounded-lg p-6 hover:border-ds-blue transition-all duration-300 group card-hover" 
                         data-product-id="{$product.pid}">
                        
                        {* Product Header *}
                        <div class="mb-6">
                            <div class="flex items-start justify-between mb-3">
                                <div class="flex-1">
                                    <h3 class="text-xl font-bold text-white mb-2 group-hover:text-ds-blue transition-colors duration-200">
                                        {$product.name}
                                    </h3>
                                    {if $product.tagline}
                                        <p class="text-ds-green text-sm font-medium mb-2">{$product.tagline}</p>
                                    {/if}
                                    {if $product.description}
                                        <p class="text-gray-400 text-sm leading-relaxed">{$product.description|truncate:120}</p>
                                    {/if}
                                </div>
                                {if $product.icon || $product.image}
                                    <div class="ml-4 flex-shrink-0">
                                        <div class="w-12 h-12 bg-gray-800 rounded-lg flex items-center justify-center border border-gray-600">
                                            {if $product.icon}
                                                <i class="{$product.icon} text-ds-blue text-xl"></i>
                                            {elseif $product.image}
                                                <img src="{$product.image}" alt="{$product.name}" class="w-8 h-8 rounded">
                                            {else}
                                                <svg class="w-6 h-6 text-ds-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                                                </svg>
                                            {/if}
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                        
                        {* Product Features *}
                        {if $product.features}
                            <div class="mb-6">
                                <h4 class="text-sm font-semibold text-gray-300 uppercase tracking-wider mb-3">Features</h4>
                                <ul class="space-y-2">
                                    {foreach from=$product.features item=feature name=features}
                                        {if $smarty.foreach.features.index < 4}
                                            <li class="flex items-center text-sm text-gray-300">
                                                <svg class="w-4 h-4 text-ds-green mr-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                </svg>
                                                <span>{$feature}</span>
                                            </li>
                                        {/if}
                                    {/foreach}
                                    {if count($product.features) > 4}
                                        <li class="text-xs text-ds-blue">
                                            +{count($product.features) - 4} more features
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                        {/if}
                        
                        {* Pricing Section *}
                        <div class="mb-6">
                            {if $product.pricing}
                                <div class="space-y-3">
                                    {foreach from=$product.pricing item=price key=cycle name=pricing}
                                        {if $smarty.foreach.pricing.first || $cycle == "monthly" || $cycle == "annually"}
                                            <div class="flex justify-between items-center p-3 bg-gray-800 rounded-lg border border-gray-600 hover:border-ds-blue/50 transition-colors duration-200">
                                                <div>
                                                    <span class="text-sm font-medium text-white capitalize">{$cycle}</span>
                                                    {if $price.setup > 0}
                                                        <div class="text-xs text-gray-400">
                                                            Setup: {$selectedCurrency.prefix}{$price.setup}{$selectedCurrency.suffix}
                                                        </div>
                                                    {/if}
                                                </div>
                                                <div class="text-right">
                                                    <span class="text-lg font-bold text-ds-green">
                                                        {$selectedCurrency.prefix}{$price.price}{$selectedCurrency.suffix}
                                                    </span>
                                                    {if $cycle != "onetime"}
                                                        <div class="text-xs text-gray-400">/{$cycle}</div>
                                                    {/if}
                                                    {if $price.save && $price.save > 0}
                                                        <div class="text-xs text-ds-purple">
                                                            Save {$price.save}%
                                                        </div>
                                                    {/if}
                                                </div>
                                            </div>
                                        {/if}
                                    {/foreach}
                                </div>
                            {else}
                                <div class="text-center p-4 bg-gray-800 rounded-lg border border-gray-600">
                                    <span class="text-lg font-bold text-ds-green">
                                        Starting at {$selectedCurrency.prefix}{$product.minprice}{$selectedCurrency.suffix}
                                    </span>
                                    <div class="text-xs text-gray-400">/month</div>
                                </div>
                            {/if}
                        </div>
                        
                        {* Action Buttons *}
                        <div class="space-y-3">
                            <button type="button" 
                                    onclick="selectProduct({$product.pid})"
                                    class="w-full btn-primary text-gray-900 font-bold py-3 px-4 rounded-lg transition-all duration-300 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950"
                                    aria-label="Select {$product.name}">
                                Select This Plan
                            </button>
                            
                            {if $product.configurable}
                                <button type="button" 
                                        onclick="configureProduct({$product.pid})"
                                        class="w-full bg-gray-700 hover:bg-gray-600 text-white py-2 px-4 rounded-lg text-sm font-medium transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 focus:ring-offset-gray-950">
                                    View Configuration Options
                                </button>
                            {/if}
                        </div>
                        
                        {* Popular/Recommended Badge *}
                        {if $product.popular || $product.recommended}
                            <div class="absolute top-4 right-4">
                                <span class="px-3 py-1 bg-ds-green text-gray-900 text-xs font-bold rounded-full animate-pulse-slow">
                                    {if $product.popular}Popular{else}Recommended{/if}
                                </span>
                            </div>
                        {/if}
                    </div>
                {/foreach}
            </div>
        </div>
    {else}
        {* No Products Available *}
        <div class="text-center py-16">
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-12 max-w-md mx-auto">
                <div class="w-20 h-20 bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-6">
                    <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                    </svg>
                </div>
                <h3 class="text-2xl font-semibold text-white mb-3">No Products Available</h3>
                <p class="text-gray-400 mb-6">
                    {if $gid}
                        No products are currently available in this category. Please try selecting a different category.
                    {else}
                        Please select a product category above to view available hosting options.
                    {/if}
                </p>
                {if $productgroups}
                    <a href="?gid={$productgroups[0].gid}" 
                       class="inline-flex items-center px-6 py-3 bg-ds-blue hover:bg-blue-600 text-white rounded-lg font-medium transition-colors duration-200">
                        Browse Products
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                {/if}
            </div>
        </div>
    {/if}
    
    {* Continue Button (if items in cart) *}
    {if $cartitems || $products}
        <div class="flex justify-between items-center pt-8 border-t border-gray-700">
            <a href="{$WEB_ROOT}" 
               class="inline-flex items-center px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors duration-200">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                </svg>
                Back to Home
            </a>
            
            {if $cartitems}
                <a href="cart.php?a=confproduct" 
                   class="inline-flex items-center px-8 py-3 btn-primary text-gray-900 rounded-lg font-bold transition-all duration-300 transform hover:scale-105">
                    Continue to Configuration
                    <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </a>
            {/if}
        </div>
    {/if}
</form>

{assign var="additionalFooter"}
<script>
    // Product selection functionality
    function selectProduct(productId) {
        // Show loading state
        OrderForm.showLoading('Adding product to cart...');
        
        // Create form data
        const formData = new FormData();
        formData.append('a', 'add');
        formData.append('pid', productId);
        formData.append('token', '{$token}');
        
        // Submit via fetch for better UX
        fetch('cart.php', {
            method: 'POST',
            body: formData,
            credentials: 'same-origin'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            // Check if response indicates success
            if (data.includes('error') || data.includes('Error')) {
                throw new Error('Server returned an error');
            }
            
            // Success - redirect to configuration
            OrderForm.showAlert('Product added successfully!', 'success');
            setTimeout(() => {
                window.location.href = 'cart.php?a=confproduct';
            }, 1000);
        })
        .catch(error => {
            console.error('Error adding product:', error);
            OrderForm.showAlert('Failed to add product to cart. Please try again.', 'error');
        })
        .finally(() => {
            OrderForm.hideLoading();
        });
    }
    
    function configureProduct(productId) {
        // Add product and go directly to configuration
        selectProduct(productId);
    }
    
    // Add product hover effects
    document.addEventListener('DOMContentLoaded', function() {
        const productCards = document.querySelectorAll('[data-product-id]');
        
        productCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-4px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
        
        // Add keyboard navigation for product selection
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && e.target.closest('[data-product-id]')) {
                const productId = e.target.closest('[data-product-id]').dataset.productId;
                if (productId) {
                    selectProduct(productId);
                }
            }
        });
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