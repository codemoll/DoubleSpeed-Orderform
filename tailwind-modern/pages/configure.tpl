{*
 * Product Configuration Page (Step 2)
 * Configure selected products with options, addons, and billing cycles
 * Enhanced UX with real-time price updates and validation
 *
 * WHMCS Variables:
 * $productinfo - Selected product information
 * $billingcycles - Available billing cycles
 * $addons - Available product addons
 * $customfields - Product custom fields
 * $configoptions - Configurable options
 * $productid - Selected product ID
 *}

{assign var="currentStep" value=2}
{assign var="pageTitle" value="Configure Product"}
{assign var="bodyContent"}

<form method="post" action="cart.php" id="configureForm" novalidate>
    <input type="hidden" name="a" value="confproduct">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="i" value="0">
    {if $productid}<input type="hidden" name="pid" value="{$productid}">{/if}
    
    {* Page Header *}
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Configure Your Product</h1>
        <p class="text-gray-400 text-lg">Customize your hosting solution to meet your specific needs</p>
    </div>
    
    {* Selected Product Overview *}
    {if $productinfo}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <div class="flex items-start justify-between">
                <div class="flex-1">
                    <div class="flex items-center space-x-3 mb-4">
                        <div class="w-12 h-12 bg-ds-blue rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                            </svg>
                        </div>
                        <div>
                            <h2 class="text-2xl font-bold text-white">{$productinfo.name}</h2>
                            {if $productinfo.tagline}
                                <p class="text-ds-green font-medium">{$productinfo.tagline}</p>
                            {/if}
                        </div>
                    </div>
                    
                    {if $productinfo.description}
                        <p class="text-gray-400 mb-4 leading-relaxed">{$productinfo.description}</p>
                    {/if}
                    
                    {* Product Features *}
                    {if $productinfo.features}
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                            {foreach from=$productinfo.features item=feature}
                                <div class="flex items-center space-x-2">
                                    <svg class="w-4 h-4 text-ds-green flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                    </svg>
                                    <span class="text-sm text-gray-300">{$feature}</span>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                </div>
                
                {if $productinfo.image}
                    <div class="ml-6 flex-shrink-0">
                        <img src="{$productinfo.image}" alt="{$productinfo.name}" class="w-24 h-24 rounded-lg bg-gray-800 border border-gray-600">
                    </div>
                {/if}
            </div>
        </div>
    {/if}
    
    {* Billing Cycle Selection *}
    {if $billingcycles}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <h3 class="text-xl font-semibold text-white mb-6 flex items-center">
                <svg class="w-6 h-6 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                Choose Billing Cycle
            </h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {foreach from=$billingcycles item=cycle key=cycleKey name=cycles}
                    <label class="relative cursor-pointer">
                        <input type="radio" 
                               name="billingcycle" 
                               value="{$cycleKey}" 
                               class="sr-only peer billing-cycle-radio"
                               {if $cycle.selected || $smarty.foreach.cycles.first}checked{/if}
                               onchange="updatePricing()"
                               data-price="{$cycle.price}"
                               data-setup="{$cycle.setup|default:0}">
                        
                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-blue peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200 h-full">
                            <div class="flex flex-col h-full">
                                <div class="flex justify-between items-start mb-2">
                                    <div>
                                        <h4 class="font-medium text-white capitalize">{$cycle.name}</h4>
                                        {if $cycle.description}
                                            <p class="text-xs text-gray-400">{$cycle.description}</p>
                                        {/if}
                                    </div>
                                    {if $cycle.save && $cycle.save > 0}
                                        <span class="px-2 py-1 bg-ds-green text-gray-900 text-xs font-bold rounded-full">
                                            Save {$cycle.save}%
                                        </span>
                                    {/if}
                                </div>
                                
                                <div class="mt-auto">
                                    <div class="text-right">
                                        <div class="text-lg font-bold text-ds-green">
                                            {$selectedCurrency.prefix}{$cycle.price}{$selectedCurrency.suffix}
                                        </div>
                                        {if $cycleKey != "onetime"}
                                            <div class="text-xs text-gray-400">/{$cycle.name}</div>
                                        {/if}
                                        {if $cycle.setup > 0}
                                            <div class="text-xs text-yellow-400 mt-1">
                                                +{$selectedCurrency.prefix}{$cycle.setup}{$selectedCurrency.suffix} setup
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </label>
                {/foreach}
            </div>
        </div>
    {/if}
    
    {* Configuration Options *}
    {if $configoptions}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <h3 class="text-xl font-semibold text-white mb-6 flex items-center">
                <svg class="w-6 h-6 text-ds-purple mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 100 4m0-4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 100 4m0-4v2m0-6V4"></path>
                </svg>
                Configuration Options
            </h3>
            
            <div class="space-y-6">
                {foreach from=$configoptions item=option}
                    <div class="border border-gray-700 rounded-lg p-4">
                        <label class="block text-sm font-medium text-gray-300 mb-3">
                            {$option.optionname}
                            {if $option.required}<span class="text-red-400">*</span>{/if}
                        </label>
                        
                        {if $option.optiontype == "dropdown"}
                            <select name="configoption[{$option.id}]" 
                                    class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                    {if $option.required}required{/if}
                                    onchange="updateConfigPricing()">
                                {foreach from=$option.options item=suboption key=subkey}
                                    <option value="{$subkey}" 
                                            {if $suboption.selected}selected{/if}
                                            data-price="{$suboption.price}">
                                        {$suboption.name}
                                        {if $suboption.price > 0}
                                            (+{$selectedCurrency.prefix}{$suboption.price}{$selectedCurrency.suffix})
                                        {/if}
                                    </option>
                                {/foreach}
                            </select>
                            
                        {elseif $option.optiontype == "radio"}
                            <div class="space-y-3">
                                {foreach from=$option.options item=suboption key=subkey}
                                    <label class="flex items-center space-x-3 cursor-pointer">
                                        <input type="radio" 
                                               name="configoption[{$option.id}]" 
                                               value="{$subkey}"
                                               class="radio-custom"
                                               {if $suboption.selected}checked{/if}
                                               {if $option.required}required{/if}
                                               onchange="updateConfigPricing()"
                                               data-price="{$suboption.price}">
                                        <div class="flex-1 flex justify-between items-center">
                                            <span class="text-white">{$suboption.name}</span>
                                            {if $suboption.price > 0}
                                                <span class="text-ds-green font-medium">
                                                    +{$selectedCurrency.prefix}{$suboption.price}{$selectedCurrency.suffix}
                                                </span>
                                            {/if}
                                        </div>
                                    </label>
                                {/foreach}
                            </div>
                            
                        {elseif $option.optiontype == "checkbox"}
                            <div class="space-y-3">
                                {foreach from=$option.options item=suboption key=subkey}
                                    <label class="flex items-center space-x-3 cursor-pointer">
                                        <input type="checkbox" 
                                               name="configoption[{$option.id}][]" 
                                               value="{$subkey}"
                                               class="checkbox-custom"
                                               {if $suboption.selected}checked{/if}
                                               onchange="updateConfigPricing()"
                                               data-price="{$suboption.price}">
                                        <div class="flex-1 flex justify-between items-center">
                                            <span class="text-white">{$suboption.name}</span>
                                            {if $suboption.price > 0}
                                                <span class="text-ds-green font-medium">
                                                    +{$selectedCurrency.prefix}{$suboption.price}{$selectedCurrency.suffix}
                                                </span>
                                            {/if}
                                        </div>
                                    </label>
                                {/foreach}
                            </div>
                            
                        {elseif $option.optiontype == "text"}
                            <input type="text" 
                                   name="configoption[{$option.id}]" 
                                   value="{$option.value}"
                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                   {if $option.required}required{/if}>
                                   
                        {elseif $option.optiontype == "textarea"}
                            <textarea name="configoption[{$option.id}]" 
                                      rows="3"
                                      class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent resize-none"
                                      {if $option.required}required{/if}>{$option.value}</textarea>
                                      
                        {elseif $option.optiontype == "quantity"}
                            <div class="flex items-center space-x-3">
                                <button type="button" 
                                        onclick="adjustQuantity('{$option.id}', -1)"
                                        class="w-10 h-10 bg-gray-800 border border-gray-600 rounded-lg flex items-center justify-center text-white hover:bg-gray-700 transition-colors duration-200">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                    </svg>
                                </button>
                                <input type="number" 
                                       name="configoption[{$option.id}]" 
                                       id="qty_{$option.id}"
                                       value="{$option.value|default:1}"
                                       min="{$option.min|default:1}"
                                       max="{$option.max|default:999}"
                                       class="w-20 bg-gray-800 border border-gray-600 rounded-lg px-3 py-2 text-white text-center focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       onchange="updateConfigPricing()"
                                       data-price="{$option.price}">
                                <button type="button" 
                                        onclick="adjustQuantity('{$option.id}', 1)"
                                        class="w-10 h-10 bg-gray-800 border border-gray-600 rounded-lg flex items-center justify-center text-white hover:bg-gray-700 transition-colors duration-200">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                    </svg>
                                </button>
                                {if $option.price > 0}
                                    <span class="text-ds-green font-medium ml-3">
                                        {$selectedCurrency.prefix}{$option.price}{$selectedCurrency.suffix} each
                                    </span>
                                {/if}
                            </div>
                        {/if}
                        
                        {if $option.description}
                            <p class="text-xs text-gray-500 mt-2">{$option.description}</p>
                        {/if}
                    </div>
                {/foreach}
            </div>
        </div>
    {/if}
    
    {* Available Addons *}
    {if $addons}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <h3 class="text-xl font-semibold text-white mb-6 flex items-center">
                <svg class="w-6 h-6 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                </svg>
                Available Add-ons
            </h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                {foreach from=$addons item=addon}
                    <div class="border border-gray-700 rounded-lg p-4 hover:border-ds-blue/50 transition-colors duration-200">
                        <div class="flex items-start justify-between mb-3">
                            <div class="flex-1">
                                <h4 class="font-medium text-white mb-1">{$addon.name}</h4>
                                {if $addon.description}
                                    <p class="text-sm text-gray-400">{$addon.description}</p>
                                {/if}
                            </div>
                            <label class="ml-3 cursor-pointer">
                                <input type="checkbox" 
                                       name="addon[{$addon.id}]" 
                                       value="1"
                                       class="checkbox-custom"
                                       {if $addon.selected}checked{/if}
                                       onchange="updateAddonPricing()"
                                       data-price="{$addon.price}"
                                       data-setup="{$addon.setup|default:0}">
                            </label>
                        </div>
                        
                        <div class="flex justify-between items-center text-sm">
                            <span class="text-gray-400">Price:</span>
                            <div class="text-right">
                                <span class="text-ds-green font-semibold">
                                    {$selectedCurrency.prefix}{$addon.price}{$selectedCurrency.suffix}
                                </span>
                                {if $addon.cycle != "onetime"}
                                    <div class="text-xs text-gray-400">/{$addon.cycle}</div>
                                {/if}
                                {if $addon.setup > 0}
                                    <div class="text-xs text-yellow-400">
                                        +{$selectedCurrency.prefix}{$addon.setup}{$selectedCurrency.suffix} setup
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    {/if}
    
    {* Custom Fields *}
    {if $customfields}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <h3 class="text-xl font-semibold text-white mb-6 flex items-center">
                <svg class="w-6 h-6 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
                Additional Information
            </h3>
            
            <div class="space-y-4">
                {foreach from=$customfields item=field}
                    <div>
                        <label for="customfield{$field.id}" class="block text-sm font-medium text-gray-300 mb-2">
                            {$field.name}
                            {if $field.required}<span class="text-red-400">*</span>{/if}
                        </label>
                        
                        {if $field.type == "text"}
                            <input type="text" 
                                   id="customfield{$field.id}"
                                   name="customfield[{$field.id}]" 
                                   value="{$field.value}"
                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                   {if $field.required}required{/if}>
                                   
                        {elseif $field.type == "password"}
                            <input type="password" 
                                   id="customfield{$field.id}"
                                   name="customfield[{$field.id}]" 
                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                   {if $field.required}required{/if}>
                                   
                        {elseif $field.type == "dropdown"}
                            <select id="customfield{$field.id}"
                                    name="customfield[{$field.id}]" 
                                    class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                    {if $field.required}required{/if}>
                                {foreach from=$field.options item=option}
                                    <option value="{$option}" {if $option == $field.value}selected{/if}>
                                        {$option}
                                    </option>
                                {/foreach}
                            </select>
                            
                        {elseif $field.type == "textarea"}
                            <textarea id="customfield{$field.id}"
                                      name="customfield[{$field.id}]" 
                                      rows="3"
                                      class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent resize-none"
                                      {if $field.required}required{/if}>{$field.value}</textarea>
                                      
                        {elseif $field.type == "checkbox"}
                            <label class="flex items-center space-x-3 cursor-pointer">
                                <input type="checkbox" 
                                       id="customfield{$field.id}"
                                       name="customfield[{$field.id}]" 
                                       value="1"
                                       class="checkbox-custom"
                                       {if $field.value}checked{/if}
                                       {if $field.required}required{/if}>
                                <span class="text-white">{$field.description}</span>
                            </label>
                        {/if}
                        
                        {if $field.description && $field.type != "checkbox"}
                            <p class="text-xs text-gray-500 mt-2">{$field.description}</p>
                        {/if}
                    </div>
                {/foreach}
            </div>
        </div>
    {/if}
    
    {* Price Summary *}
    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
        <h3 class="text-xl font-semibold text-white mb-4">Price Summary</h3>
        <div class="space-y-3" id="price-summary">
            <div class="flex justify-between items-center">
                <span class="text-gray-300">Base Price:</span>
                <span class="text-white font-medium" id="base-price">
                    {$selectedCurrency.prefix}0.00{$selectedCurrency.suffix}
                </span>
            </div>
            <div class="flex justify-between items-center" id="config-price-row" style="display: none;">
                <span class="text-gray-300">Configuration:</span>
                <span class="text-ds-blue font-medium" id="config-price">
                    {$selectedCurrency.prefix}0.00{$selectedCurrency.suffix}
                </span>
            </div>
            <div class="flex justify-between items-center" id="addon-price-row" style="display: none;">
                <span class="text-gray-300">Add-ons:</span>
                <span class="text-ds-purple font-medium" id="addon-price">
                    {$selectedCurrency.prefix}0.00{$selectedCurrency.suffix}
                </span>
            </div>
            <div class="flex justify-between items-center" id="setup-price-row" style="display: none;">
                <span class="text-gray-300">Setup Fees:</span>
                <span class="text-yellow-400 font-medium" id="setup-price">
                    {$selectedCurrency.prefix}0.00{$selectedCurrency.suffix}
                </span>
            </div>
            <div class="border-t border-gray-600 pt-3">
                <div class="flex justify-between items-center">
                    <span class="text-lg font-semibold text-white">Total:</span>
                    <span class="text-xl font-bold text-ds-green" id="total-price">
                        {$selectedCurrency.prefix}0.00{$selectedCurrency.suffix}
                    </span>
                </div>
                <div class="text-xs text-gray-400 text-right mt-1" id="billing-cycle-info">
                    Select a billing cycle above
                </div>
            </div>
        </div>
    </div>
    
    {* Navigation Buttons *}
    <div class="flex justify-between items-center pt-8 border-t border-gray-700">
        <a href="cart.php?a=view" 
           class="inline-flex items-center px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors duration-200">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            Back to Products
        </a>
        
        <button type="submit" 
                class="inline-flex items-center px-8 py-3 btn-primary text-gray-900 rounded-lg font-bold transition-all duration-300 transform hover:scale-105">
            Continue to Domain Selection
            <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
            </svg>
        </button>
    </div>
</form>

{assign var="additionalFooter"}
<script>
    // Configuration form functionality
    function updatePricing() {
        const selectedCycle = document.querySelector('input[name="billingcycle"]:checked');
        if (!selectedCycle) return;
        
        const basePrice = parseFloat(selectedCycle.dataset.price || 0);
        const setupPrice = parseFloat(selectedCycle.dataset.setup || 0);
        const cycleName = selectedCycle.closest('label').querySelector('h4').textContent;
        
        document.getElementById('base-price').textContent = formatCurrency(basePrice);
        document.getElementById('billing-cycle-info').textContent = `per ${cycleName.toLowerCase()}`;
        
        updateConfigPricing();
        updateAddonPricing();
        calculateTotal();
    }
    
    function updateConfigPricing() {
        let configTotal = 0;
        
        // Dropdown config options
        document.querySelectorAll('select[name^="configoption"]').forEach(select => {
            const selected = select.selectedOptions[0];
            if (selected) {
                configTotal += parseFloat(selected.dataset.price || 0);
            }
        });
        
        // Radio config options
        document.querySelectorAll('input[name^="configoption"]:checked').forEach(radio => {
            configTotal += parseFloat(radio.dataset.price || 0);
        });
        
        // Checkbox config options
        document.querySelectorAll('input[type="checkbox"][name^="configoption"]:checked').forEach(checkbox => {
            configTotal += parseFloat(checkbox.dataset.price || 0);
        });
        
        // Quantity config options
        document.querySelectorAll('input[type="number"][name^="configoption"]').forEach(input => {
            const quantity = parseInt(input.value || 0);
            const price = parseFloat(input.dataset.price || 0);
            configTotal += quantity * price;
        });
        
        const configRow = document.getElementById('config-price-row');
        if (configTotal > 0) {
            document.getElementById('config-price').textContent = formatCurrency(configTotal);
            configRow.style.display = 'flex';
        } else {
            configRow.style.display = 'none';
        }
        
        calculateTotal();
    }
    
    function updateAddonPricing() {
        let addonTotal = 0;
        let setupTotal = 0;
        
        document.querySelectorAll('input[name^="addon"]:checked').forEach(checkbox => {
            addonTotal += parseFloat(checkbox.dataset.price || 0);
            setupTotal += parseFloat(checkbox.dataset.setup || 0);
        });
        
        const addonRow = document.getElementById('addon-price-row');
        const setupRow = document.getElementById('setup-price-row');
        
        if (addonTotal > 0) {
            document.getElementById('addon-price').textContent = formatCurrency(addonTotal);
            addonRow.style.display = 'flex';
        } else {
            addonRow.style.display = 'none';
        }
        
        // Update setup fees (includes base setup + addon setup)
        const selectedCycle = document.querySelector('input[name="billingcycle"]:checked');
        const baseSetup = selectedCycle ? parseFloat(selectedCycle.dataset.setup || 0) : 0;
        const totalSetup = baseSetup + setupTotal;
        
        if (totalSetup > 0) {
            document.getElementById('setup-price').textContent = formatCurrency(totalSetup);
            setupRow.style.display = 'flex';
        } else {
            setupRow.style.display = 'none';
        }
        
        calculateTotal();
    }
    
    function calculateTotal() {
        const basePrice = parseFloat(document.getElementById('base-price').textContent.replace(/[^0-9.]/g, '')) || 0;
        const configPrice = parseFloat(document.getElementById('config-price').textContent.replace(/[^0-9.]/g, '')) || 0;
        const addonPrice = parseFloat(document.getElementById('addon-price').textContent.replace(/[^0-9.]/g, '')) || 0;
        const setupPrice = parseFloat(document.getElementById('setup-price').textContent.replace(/[^0-9.]/g, '')) || 0;
        
        const total = basePrice + configPrice + addonPrice + setupPrice;
        document.getElementById('total-price').textContent = formatCurrency(total);
    }
    
    function adjustQuantity(optionId, change) {
        const input = document.getElementById('qty_' + optionId);
        if (!input) return;
        
        const currentValue = parseInt(input.value) || 1;
        const min = parseInt(input.min) || 1;
        const max = parseInt(input.max) || 999;
        
        const newValue = Math.min(Math.max(currentValue + change, min), max);
        input.value = newValue;
        
        updateConfigPricing();
    }
    
    function formatCurrency(amount) {
        return '{$selectedCurrency.prefix}' + parseFloat(amount).toFixed(2) + '{$selectedCurrency.suffix}';
    }
    
    // Initialize configuration form
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize pricing
        updatePricing();
        
        // Form validation
        document.getElementById('configureForm').addEventListener('submit', function(e) {
            const validation = OrderForm.validation.validateForm(this);
            if (!validation.isValid) {
                e.preventDefault();
                OrderForm.showAlert('Please fill in all required fields.', 'error');
                
                // Focus first invalid field
                const firstInvalid = this.querySelector(':invalid, .border-red-500');
                if (firstInvalid) firstInvalid.focus();
                return false;
            }
            
            // Show loading state
            OrderForm.showLoading('Saving configuration...');
        });
        
        // Add change listeners for all pricing elements
        document.querySelectorAll('input[name="billingcycle"]').forEach(radio => {
            radio.addEventListener('change', updatePricing);
        });
        
        document.querySelectorAll('select[name^="configoption"], input[name^="configoption"]').forEach(element => {
            element.addEventListener('change', updateConfigPricing);
        });
        
        document.querySelectorAll('input[name^="addon"]').forEach(checkbox => {
            checkbox.addEventListener('change', updateAddonPricing);
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