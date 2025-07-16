{*
 * Step 1: Product Selection
 * Multi-step wizard - Product selection page
 * DoubleSpeedHost themed with Tailwind CSS
 *
 * WHMCS Variables:
 * $productgroups - Available product groups
 * $products - Products in selected group
 * $currencies - Available currencies
 * $selectedCurrency - Currently selected currency
 *}

{* Set current step for progress indicator *}
{assign var="currentStep" value=1}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Products - DoubleSpeedHost</title>
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
                <form method="post" action="cart.php?a=add" id="productForm">
                    {* Page Header *}
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold text-white mb-2">Select Your Products</h1>
                        <p class="text-gray-400">Choose from our high-performance hosting solutions</p>
                    </div>
                    
                    {* Product Groups Navigation *}
                    {if $productgroups}
                        <div class="mb-8">
                            <div class="flex flex-wrap gap-2">
                                {foreach from=$productgroups item=group}
                                    <a href="?gid={$group.gid}" 
                                       class="px-4 py-2 rounded-lg border transition-all duration-200
                                              {if $group.gid == $smarty.get.gid}
                                                  bg-ds-blue border-ds-blue text-white
                                              {else}
                                                  bg-gray-800 border-gray-600 text-gray-300 hover:bg-gray-700 hover:border-ds-blue
                                              {/if}">
                                        {$group.name}
                                    </a>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Products Grid *}
                    {if $products}
                        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                            {foreach from=$products item=product}
                                <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 hover:border-ds-blue transition-all duration-300 group">
                                    {* Product Header *}
                                    <div class="mb-4">
                                        <h3 class="text-xl font-bold text-white mb-2 group-hover:text-ds-blue transition-colors">
                                            {$product.name}
                                        </h3>
                                        {if $product.description}
                                            <p class="text-gray-400 text-sm">{$product.description}</p>
                                        {/if}
                                    </div>
                                    
                                    {* Product Features *}
                                    {if $product.features}
                                        <div class="mb-6">
                                            <ul class="space-y-2">
                                                {foreach from=$product.features item=feature}
                                                    <li class="flex items-center text-sm text-gray-300">
                                                        <svg class="w-4 h-4 text-ds-green mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                        </svg>
                                                        {$feature}
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        </div>
                                    {/if}
                                    
                                    {* Pricing *}
                                    <div class="mb-6">
                                        {if $product.pricing}
                                            <div class="space-y-2">
                                                {foreach from=$product.pricing item=price key=cycle}
                                                    <div class="flex justify-between items-center p-3 bg-gray-800 rounded-lg border border-gray-600">
                                                        <div>
                                                            <span class="text-sm text-gray-300">{$cycle}</span>
                                                        </div>
                                                        <div class="text-right">
                                                            <span class="text-lg font-bold text-ds-green">
                                                                {$selectedCurrency.prefix}{$price.price}{$selectedCurrency.suffix}
                                                            </span>
                                                            {if $price.cycle != "onetime"}
                                                                <div class="text-xs text-gray-400">/{$price.cycle}</div>
                                                            {/if}
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {else}
                                            <div class="text-center p-4 bg-gray-800 rounded-lg">
                                                <span class="text-lg font-bold text-ds-green">Starting at {$selectedCurrency.prefix}{$product.pricing.monthly.price}{$selectedCurrency.suffix}</span>
                                                <div class="text-xs text-gray-400">/month</div>
                                            </div>
                                        {/if}
                                    </div>
                                    
                                    {* Action Button *}
                                    <button type="button" 
                                            onclick="selectProduct({$product.pid})"
                                            class="w-full bg-gradient-to-r from-ds-green to-ds-blue hover:from-ds-blue hover:to-ds-purple text-gray-900 font-bold py-3 px-4 rounded-lg transition-all duration-300 transform hover:scale-105">
                                        Select Product
                                    </button>
                                </div>
                            {/foreach}
                        </div>
                    {else}
                        {* No Products Message *}
                        <div class="text-center py-12">
                            <div class="bg-gray-900 border border-gray-700 rounded-lg p-8">
                                <div class="w-16 h-16 bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                                    </svg>
                                </div>
                                <h3 class="text-xl font-semibold text-white mb-2">No Products Available</h3>
                                <p class="text-gray-400">Please select a product category to view available options.</p>
                            </div>
                        </div>
                    {/if}
                    
                    {* Hidden form fields for WHMCS *}
                    <input type="hidden" name="pid" id="selectedProduct" value="">
                    <input type="hidden" name="billingcycle" id="selectedCycle" value="">
                </form>
            </div>
            
            {* Sidebar Summary *}
            <div class="lg:col-span-1">
                {include file="sidebar-summary.tpl" 
                         products=$cart.products 
                         subtotal=$cart.subtotal 
                         total=$cart.total 
                         currency=$selectedCurrency}
            </div>
        </div>
    </div>
    
    <script>
        function selectProduct(pid) {
            document.getElementById('selectedProduct').value = pid;
            // Redirect to next step or submit form
            window.location.href = 'cart.php?a=confproduct&i=0';
        }
        
        // Add smooth scrolling for better UX
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>