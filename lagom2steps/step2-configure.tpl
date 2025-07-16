{*
 * Step 2: Product Configuration
 * Multi-step wizard - Product configuration page
 * DoubleSpeedHost themed with Tailwind CSS
 *
 * WHMCS Variables:
 * $productinfo - Selected product information
 * $billingcycles - Available billing cycles
 * $addons - Available product addons
 * $customfields - Product custom fields
 * $configoptions - Configurable options
 *}

{* Set current step for progress indicator *}
{assign var="currentStep" value=2}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Configure Product - DoubleSpeedHost</title>
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
                <form method="post" action="cart.php" id="configForm">
                    {* Page Header *}
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold text-white mb-2">Configure Your Product</h1>
                        <p class="text-gray-400">Customize your hosting solution to meet your needs</p>
                    </div>
                    
                    {* Selected Product Overview *}
                    {if $productinfo}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <div class="flex items-start justify-between">
                                <div class="flex-1">
                                    <h2 class="text-xl font-bold text-white mb-2">{$productinfo.name}</h2>
                                    <p class="text-gray-400 mb-4">{$productinfo.description}</p>
                                    
                                    {* Product Features *}
                                    {if $productinfo.features}
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            {foreach from=$productinfo.features item=feature}
                                                <div class="flex items-center">
                                                    <svg class="w-4 h-4 text-ds-green mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                    </svg>
                                                    <span class="text-sm text-gray-300">{$feature}</span>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="ml-6">
                                    <img src="{$productinfo.image}" alt="{$productinfo.name}" class="w-16 h-16 rounded-lg bg-gray-800">
                                </div>
                            </div>
                        </div>
                    {/if}
                    
                    {* Billing Cycle Selection *}
                    {if $billingcycles}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-blue mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                Billing Cycle
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                {foreach from=$billingcycles item=cycle key=cycleKey}
                                    <label class="relative cursor-pointer">
                                        <input type="radio" 
                                               name="billingcycle" 
                                               value="{$cycleKey}" 
                                               class="sr-only peer"
                                               {if $cycle.selected}checked{/if}>
                                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-blue peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200">
                                            <div class="flex justify-between items-start mb-2">
                                                <span class="font-medium text-white">{$cycle.name}</span>
                                                {if $cycle.discount}
                                                    <span class="bg-ds-green text-gray-900 text-xs px-2 py-1 rounded-full font-bold">
                                                        Save {$cycle.discount}%
                                                    </span>
                                                {/if}
                                            </div>
                                            <div class="text-2xl font-bold text-ds-green">
                                                {$selectedCurrency.prefix}{$cycle.price}{$selectedCurrency.suffix}
                                            </div>
                                            <div class="text-sm text-gray-400">
                                                {if $cycle.setup > 0}
                                                    Setup: {$selectedCurrency.prefix}{$cycle.setup}{$selectedCurrency.suffix}
                                                {else}
                                                    Free Setup
                                                {/if}
                                            </div>
                                        </div>
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Configurable Options *}
                    {if $configoptions}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-purple mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 100 4m0-4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 100 4m0-4v2m0-6V4"></path>
                                </svg>
                                Configuration Options
                            </h3>
                            <div class="space-y-6">
                                {foreach from=$configoptions item=option}
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            {$option.optionname}
                                            {if $option.required}<span class="text-red-400">*</span>{/if}
                                        </label>
                                        
                                        {if $option.optiontype == "dropdown"}
                                            <select name="configoption[{$option.id}]" 
                                                    class="w-full bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                                {foreach from=$option.options item=suboption}
                                                    <option value="{$suboption.id}" {if $suboption.selected}selected{/if}>
                                                        {$suboption.name}
                                                        {if $suboption.price > 0}
                                                            (+{$selectedCurrency.prefix}{$suboption.price}{$selectedCurrency.suffix})
                                                        {/if}
                                                    </option>
                                                {/foreach}
                                            </select>
                                            
                                        {elseif $option.optiontype == "radio"}
                                            <div class="space-y-2">
                                                {foreach from=$option.options item=suboption}
                                                    <label class="flex items-center">
                                                        <input type="radio" 
                                                               name="configoption[{$option.id}]" 
                                                               value="{$suboption.id}"
                                                               {if $suboption.selected}checked{/if}
                                                               class="text-ds-blue focus:ring-ds-blue">
                                                        <span class="ml-2 text-gray-300">
                                                            {$suboption.name}
                                                            {if $suboption.price > 0}
                                                                <span class="text-ds-green">
                                                                    (+{$selectedCurrency.prefix}{$suboption.price}{$selectedCurrency.suffix})
                                                                </span>
                                                            {/if}
                                                        </span>
                                                    </label>
                                                {/foreach}
                                            </div>
                                            
                                        {elseif $option.optiontype == "text"}
                                            <input type="text" 
                                                   name="configoption[{$option.id}]" 
                                                   value="{$option.value}"
                                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                                   {if $option.required}required{/if}>
                                        {/if}
                                        
                                        {if $option.description}
                                            <p class="mt-1 text-xs text-gray-400">{$option.description}</p>
                                        {/if}
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Available Addons *}
                    {if $addons}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-green mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                </svg>
                                Available Add-ons
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                {foreach from=$addons item=addon}
                                    <label class="relative cursor-pointer">
                                        <input type="checkbox" 
                                               name="addons[]" 
                                               value="{$addon.id}" 
                                               class="sr-only peer">
                                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-green peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200">
                                            <div class="flex items-start justify-between">
                                                <div class="flex-1">
                                                    <h4 class="font-medium text-white">{$addon.name}</h4>
                                                    <p class="text-sm text-gray-400 mt-1">{$addon.description}</p>
                                                </div>
                                                <div class="ml-4 text-right">
                                                    <span class="text-lg font-bold text-ds-green">
                                                        {$selectedCurrency.prefix}{$addon.price}{$selectedCurrency.suffix}
                                                    </span>
                                                    <div class="text-xs text-gray-400">/{$addon.cycle}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Custom Fields *}
                    {if $customfields}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <h3 class="text-lg font-semibold text-white mb-4">Additional Information</h3>
                            <div class="space-y-4">
                                {foreach from=$customfields item=field}
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            {$field.fieldname}
                                            {if $field.required}<span class="text-red-400">*</span>{/if}
                                        </label>
                                        
                                        {if $field.fieldtype == "text"}
                                            <input type="text" 
                                                   name="customfield[{$field.id}]" 
                                                   value="{$field.value}"
                                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                                   {if $field.required}required{/if}>
                                                   
                                        {elseif $field.fieldtype == "textarea"}
                                            <textarea name="customfield[{$field.id}]" 
                                                      rows="3"
                                                      class="w-full bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                                      {if $field.required}required{/if}>{$field.value}</textarea>
                                                      
                                        {elseif $field.fieldtype == "dropdown"}
                                            <select name="customfield[{$field.id}]" 
                                                    class="w-full bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                                    {if $field.required}required{/if}>
                                                <option value="">Please Choose...</option>
                                                {foreach from=$field.options item=option}
                                                    <option value="{$option}" {if $option == $field.value}selected{/if}>{$option}</option>
                                                {/foreach}
                                            </select>
                                        {/if}
                                        
                                        {if $field.description}
                                            <p class="mt-1 text-xs text-gray-400">{$field.description}</p>
                                        {/if}
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    
                    {* Navigation Buttons *}
                    <div class="flex justify-between">
                        <a href="cart.php" 
                           class="bg-gray-700 hover:bg-gray-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                            ← Back to Products
                        </a>
                        <button type="submit" 
                                name="a" 
                                value="confdomains"
                                class="bg-gradient-to-r from-ds-green to-ds-blue hover:from-ds-blue hover:to-ds-purple text-gray-900 font-bold px-8 py-3 rounded-lg transition-all duration-300 transform hover:scale-105">
                            Continue to Domain Selection →
                        </button>
                    </div>
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
        // Update pricing when configuration changes
        document.addEventListener('change', function(e) {
            if (e.target.name && (e.target.name.includes('billingcycle') || e.target.name.includes('configoption'))) {
                updatePricing();
            }
        });
        
        function updatePricing() {
            // AJAX call to update pricing based on selections
            // This would integrate with WHMCS pricing calculations
        }
        
        // Form validation
        document.getElementById('configForm').addEventListener('submit', function(e) {
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value) {
                    isValid = false;
                    field.classList.add('border-red-500');
                } else {
                    field.classList.remove('border-red-500');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    </script>
</body>
</html>