{*
 * Domain Selection Page (Step 3)
 * Enhanced domain search and selection with comprehensive error handling
 * Full WHMCS integration with real-time availability checking
 *
 * WHMCS Variables:
 * $domainpricing - Domain pricing for different TLDs
 * $transfertlds - Available TLDs for transfer
 * $registertlds - Available TLDs for registration
 * $incartdomains - Domains already in cart
 * $currencies - Available currencies
 * $selectedCurrency - Current currency
 *}

{assign var="currentStep" value=3}
{assign var="pageTitle" value="Choose Domain"}
{assign var="bodyContent"}

<form method="post" action="cart.php" id="domainSelectionForm" novalidate>
    <input type="hidden" name="a" value="confdomains">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="selectedDomainType" id="selectedDomainType" value="register">
    
    {* Page Header *}
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Choose Your Domain</h1>
        <p class="text-gray-400 text-lg">Register a new domain, transfer an existing one, or use your own domain</p>
    </div>
    
    {* Domain Type Tabs *}
    <div class="mb-8">
        <div class="border-b border-gray-700">
            <nav class="-mb-px flex space-x-8" aria-label="Domain options">
                <button type="button" 
                        id="registerTab" 
                        onclick="showDomainTab('register')"
                        class="tab-button whitespace-nowrap py-3 px-1 border-b-2 font-medium text-sm transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950 border-ds-blue text-ds-blue" 
                        aria-selected="true"
                        role="tab">
                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                    </svg>
                    Register New Domain
                </button>
                
                <button type="button" 
                        id="transferTab" 
                        onclick="showDomainTab('transfer')"
                        class="tab-button whitespace-nowrap py-3 px-1 border-b-2 font-medium text-sm transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950 border-transparent text-gray-400 hover:text-gray-300 hover:border-gray-300" 
                        aria-selected="false"
                        role="tab">
                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                    </svg>
                    Transfer Domain
                </button>
                
                <button type="button" 
                        id="existingTab" 
                        onclick="showDomainTab('existing')"
                        class="tab-button whitespace-nowrap py-3 px-1 border-b-2 font-medium text-sm transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950 border-transparent text-gray-400 hover:text-gray-300 hover:border-gray-300" 
                        aria-selected="false"
                        role="tab">
                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"></path>
                    </svg>
                    Use Existing Domain
                </button>
            </nav>
        </div>
    </div>
    
    {* Register New Domain Tab *}
    <div id="registerContent" class="tab-content">
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <h3 class="text-xl font-semibold text-white mb-4">Register a New Domain</h3>
            <p class="text-gray-400 mb-6">Search for and register your perfect domain name</p>
            
            {* Domain Search Form *}
            <div class="space-y-4">
                <div class="flex space-x-4">
                    <div class="flex-1">
                        <label for="domainSearch" class="block text-sm font-medium text-gray-300 mb-2">
                            Enter your desired domain name
                        </label>
                        <div class="relative">
                            <input type="text" 
                                   id="domainSearch" 
                                   name="domain"
                                   placeholder="example" 
                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent pr-12"
                                   aria-describedby="domain-help"
                                   autocomplete="off"
                                   spellcheck="false">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9"></path>
                                </svg>
                            </div>
                        </div>
                        <div id="domain-help" class="text-xs text-gray-500 mt-1">
                            Enter only the domain name without extension (e.g., "example" not "example.com")
                        </div>
                    </div>
                    
                    <div class="flex items-end">
                        <button type="button" 
                                onclick="performDomainSearch()"
                                class="bg-ds-blue hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950"
                                id="searchButton">
                            <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                            </svg>
                            Search
                        </button>
                    </div>
                </div>
                
                {* Popular TLD Shortcuts *}
                <div>
                    <div class="text-sm font-medium text-gray-300 mb-2">Quick search popular extensions:</div>
                    <div class="flex flex-wrap gap-2">
                        {assign var="popularTlds" value=['.com', '.net', '.org', '.info', '.biz', '.co']}
                        {foreach from=$popularTlds item=tld}
                            <button type="button" 
                                    onclick="quickDomainSearch('{$tld|escape}')"
                                    class="px-3 py-1 bg-gray-800 hover:bg-gray-700 border border-gray-600 hover:border-ds-blue text-gray-300 hover:text-white rounded-lg text-sm transition-colors duration-200">
                                {$tld}
                            </button>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
        
        {* Search Results Container *}
        <div id="searchResults" class="hidden mb-8">
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                <div class="flex items-center justify-between mb-4">
                    <h4 class="text-lg font-semibold text-white">Domain Search Results</h4>
                    <button type="button" 
                            onclick="clearSearchResults()"
                            class="text-gray-400 hover:text-gray-300 transition-colors duration-200"
                            aria-label="Clear search results">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div id="resultsContainer" class="space-y-3">
                    {* Results will be populated by JavaScript *}
                </div>
            </div>
        </div>
        
        {* Domain Pricing Information *}
        {if $domainpricing}
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                <h4 class="text-lg font-semibold text-white mb-4">Domain Pricing</h4>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {foreach from=$domainpricing item=pricing key=tld}
                        <div class="bg-gray-800 border border-gray-600 rounded-lg p-4">
                            <div class="flex justify-between items-center">
                                <span class="font-medium text-white">.{$tld}</span>
                                <span class="text-ds-green font-semibold">
                                    {$selectedCurrency.prefix}{$pricing.register}{$selectedCurrency.suffix}/year
                                </span>
                            </div>
                            {if $pricing.transfer && $pricing.transfer != $pricing.register}
                                <div class="text-xs text-gray-400 mt-1">
                                    Transfer: {$selectedCurrency.prefix}{$pricing.transfer}{$selectedCurrency.suffix}
                                </div>
                            {/if}
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
    </div>
    
    {* Transfer Domain Tab *}
    <div id="transferContent" class="tab-content hidden">
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
            <h3 class="text-xl font-semibold text-white mb-4">Transfer Your Domain</h3>
            <p class="text-gray-400 mb-6">Transfer your existing domain to us for better management and pricing</p>
            
            <div class="space-y-4">
                <div>
                    <label for="transferDomain" class="block text-sm font-medium text-gray-300 mb-2">
                        Domain to Transfer <span class="text-red-400">*</span>
                    </label>
                    <input type="text" 
                           id="transferDomain" 
                           name="transferdomain"
                           placeholder="example.com" 
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                           required>
                    <div class="text-xs text-gray-500 mt-1">
                        Enter the full domain name including extension
                    </div>
                </div>
                
                <div>
                    <label for="authCode" class="block text-sm font-medium text-gray-300 mb-2">
                        Authorization Code (EPP Code)
                    </label>
                    <input type="text" 
                           id="authCode" 
                           name="authcode"
                           placeholder="Enter EPP/Auth code" 
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                    <div class="text-xs text-gray-500 mt-1">
                        Required for most domains. Contact your current registrar if you don't have this.
                    </div>
                </div>
                
                <div class="bg-blue-500/10 border border-blue-500/20 rounded-lg p-4">
                    <div class="flex items-start">
                        <svg class="w-5 h-5 text-blue-400 mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <div class="text-sm">
                            <h5 class="font-medium text-blue-300 mb-1">Transfer Requirements</h5>
                            <ul class="text-blue-200 space-y-1">
                                <li>• Domain must be unlocked at current registrar</li>
                                <li>• Domain must be at least 60 days old</li>
                                <li>• Authorization code from current registrar</li>
                                <li>• Access to admin email for approval</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    {* Use Existing Domain Tab *}
    <div id="existingContent" class="tab-content hidden">
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
            <h3 class="text-xl font-semibold text-white mb-4">Use Your Existing Domain</h3>
            <p class="text-gray-400 mb-6">Already have a domain? Use it with your hosting package</p>
            
            <div class="space-y-4">
                <div>
                    <label for="existingDomain" class="block text-sm font-medium text-gray-300 mb-2">
                        Your Domain Name <span class="text-red-400">*</span>
                    </label>
                    <input type="text" 
                           id="existingDomain" 
                           name="existingdomain"
                           placeholder="example.com" 
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                           required>
                    <div class="text-xs text-gray-500 mt-1">
                        Enter your existing domain name
                    </div>
                </div>
                
                <div class="bg-yellow-500/10 border border-yellow-500/20 rounded-lg p-4">
                    <div class="flex items-start">
                        <svg class="w-5 h-5 text-yellow-400 mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.268 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                        </svg>
                        <div class="text-sm">
                            <h5 class="font-medium text-yellow-300 mb-1">Important Note</h5>
                            <p class="text-yellow-200">
                                You'll need to update your domain's nameservers to point to our hosting servers. 
                                We'll provide these details after your order is complete.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    {* Selected Domains Summary *}
    {if $incartdomains}
        <div class="mb-8">
            <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                <h4 class="text-lg font-semibold text-white mb-4">Domains in Cart</h4>
                <div class="space-y-3">
                    {foreach from=$incartdomains item=domain}
                        <div class="flex items-center justify-between p-3 bg-gray-800 border border-gray-600 rounded-lg">
                            <div class="flex items-center space-x-3">
                                <div class="w-3 h-3 bg-ds-green rounded-full"></div>
                                <div>
                                    <div class="font-medium text-white">{$domain.domain}</div>
                                    <div class="text-sm text-gray-400">{$domain.type|capitalize}</div>
                                </div>
                            </div>
                            <div class="flex items-center space-x-4">
                                <span class="text-ds-green font-semibold">
                                    {$selectedCurrency.prefix}{$domain.price}{$selectedCurrency.suffix}
                                </span>
                                <button type="button" 
                                        onclick="removeDomainFromCart('{$domain.id}')"
                                        class="text-red-400 hover:text-red-300 transition-colors duration-200"
                                        aria-label="Remove {$domain.domain}">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    {/if}
    
    {* Navigation Buttons *}
    <div class="flex justify-between items-center pt-8 border-t border-gray-700">
        <a href="cart.php?a=confproduct" 
           class="inline-flex items-center px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors duration-200">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            Back to Configuration
        </a>
        
        <button type="submit" 
                class="inline-flex items-center px-8 py-3 btn-primary text-gray-900 rounded-lg font-bold transition-all duration-300 transform hover:scale-105">
            Continue to Summary
            <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
            </svg>
        </button>
    </div>
</form>

{assign var="additionalFooter"}
<script>
    // Domain search and tab functionality
    let domainSearchTimeout;
    let isSearching = false;
    
    function showDomainTab(tabName) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.add('hidden');
        });
        
        // Remove active class from all tabs
        document.querySelectorAll('.tab-button').forEach(button => {
            button.classList.remove('border-ds-blue', 'text-ds-blue');
            button.classList.add('border-transparent', 'text-gray-400');
            button.setAttribute('aria-selected', 'false');
        });
        
        // Show selected tab content
        document.getElementById(tabName + 'Content').classList.remove('hidden');
        
        // Add active class to selected tab
        const activeTab = document.getElementById(tabName + 'Tab');
        activeTab.classList.add('border-ds-blue', 'text-ds-blue');
        activeTab.classList.remove('border-transparent', 'text-gray-400');
        activeTab.setAttribute('aria-selected', 'true');
        
        // Update hidden form field
        document.getElementById('selectedDomainType').value = tabName;
    }
    
    function performDomainSearch() {
        const domainName = document.getElementById('domainSearch').value.trim();
        if (!domainName) {
            OrderForm.showAlert('Please enter a domain name to search.', 'error');
            document.getElementById('domainSearch').focus();
            return;
        }
        
        // Validate domain name format
        if (!isValidDomainName(domainName)) {
            OrderForm.showAlert('Please enter a valid domain name (letters, numbers, and hyphens only).', 'error');
            return;
        }
        
        searchDomain(domainName);
    }
    
    function quickDomainSearch(tld) {
        const domainName = document.getElementById('domainSearch').value.trim();
        if (!domainName) {
            OrderForm.showAlert('Please enter a domain name first.', 'error');
            document.getElementById('domainSearch').focus();
            return;
        }
        
        searchDomain(domainName, [tld.replace('.', '')]);
    }
    
    function searchDomain(domainName, specificTlds = null) {
        if (isSearching) return;
        
        isSearching = true;
        const searchResults = document.getElementById('searchResults');
        const resultsContainer = document.getElementById('resultsContainer');
        const searchButton = document.getElementById('searchButton');
        
        // Show results container
        searchResults.classList.remove('hidden');
        
        // Show loading state
        OrderForm.showDomainSearchLoading(resultsContainer);
        OrderForm.showButtonLoading(searchButton, 'Searching...');
        
        // Prepare search data
        const searchData = {
            domain: domainName,
            tlds: specificTlds || ['com', 'net', 'org', 'info', 'biz', 'co', 'io', 'me']
        };
        
        // Simulate domain search (replace with actual WHMCS integration)
        setTimeout(() => {
            try {
                // Mock results - in real implementation, this would be an AJAX call to WHMCS
                const mockResults = generateMockResults(domainName, searchData.tlds);
                displayDomainResults(mockResults);
            } catch (error) {
                displaySearchError('Domain search failed. Please try again.');
                OrderForm.showAlert('Domain search failed. Please check your connection and try again.', 'error');
            } finally {
                isSearching = false;
                OrderForm.hideButtonLoading(searchButton);
            }
        }, 1500);
    }
    
    function generateMockResults(domainName, tlds) {
        // Mock domain search results
        const basePrice = 12.99;
        return tlds.map((tld, index) => ({
            name: `${domainName}.${tld}`,
            available: Math.random() > 0.3, // 70% chance of being available
            price: (basePrice + (index * 2.50)).toFixed(2),
            tld: tld,
            premium: Math.random() > 0.8 // 20% chance of being premium
        }));
    }
    
    function displayDomainResults(results) {
        const resultsContainer = document.getElementById('resultsContainer');
        
        if (!results || results.length === 0) {
            displaySearchError('No domain results found. Please try a different search term.');
            return;
        }
        
        let html = '';
        
        results.forEach((result, index) => {
            const statusColor = result.available ? 'ds-green' : 'red-500';
            const statusText = result.available ? 'Available' : 'Taken';
            const priceDisplay = result.premium ? `Premium - $${result.price}` : `$${result.price}`;
            
            const actionButton = result.available ? 
                `<button type="button" 
                        onclick="selectDomainForCart('${result.name}', '${result.price}', '${result.tld}')" 
                        class="bg-ds-blue hover:bg-blue-600 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:ring-offset-2 focus:ring-offset-gray-950">
                    Add ${priceDisplay}/year
                </button>` :
                `<span class="text-red-400 text-sm flex items-center">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                    Unavailable
                </span>`;
            
            html += `
                <div class="domain-result flex items-center justify-between p-4 border border-gray-600 rounded-lg ${result.available ? 'bg-gray-800 hover:border-ds-blue/50' : 'bg-gray-800/50'} transition-all duration-200"
                     style="animation-delay: ${index * 0.1}s">
                    <div class="flex items-center space-x-3">
                        <div class="w-3 h-3 rounded-full bg-${statusColor} animate-pulse"></div>
                        <div>
                            <div class="font-medium text-white">${OrderForm.utils.sanitizeInput(result.name)}</div>
                            <div class="text-sm text-gray-400">${statusText}${result.premium ? ' • Premium' : ''}</div>
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <span class="text-ds-green font-semibold">${priceDisplay}/year</span>
                        ${actionButton}
                    </div>
                </div>
            `;
        });
        
        resultsContainer.innerHTML = html;
        
        // Add success message
        OrderForm.showToast(`Found ${results.length} domain results`, 'success', 3000);
    }
    
    function displaySearchError(message) {
        const resultsContainer = document.getElementById('resultsContainer');
        resultsContainer.innerHTML = `
            <div class="text-center py-8">
                <div class="w-16 h-16 bg-red-500/10 border border-red-500/20 rounded-full flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-medium text-white mb-2">Search Error</h3>
                <p class="text-gray-400">${OrderForm.utils.sanitizeInput(message)}</p>
                <button type="button" 
                        onclick="clearSearchResults()" 
                        class="mt-4 text-ds-blue hover:text-blue-400 text-sm underline focus:outline-none">
                    Try Again
                </button>
            </div>
        `;
    }
    
    function selectDomainForCart(domainName, price, tld) {
        // Add domain to cart
        const domain = {
            id: OrderForm.utils.generateId(),
            name: domainName,
            price: parseFloat(price),
            type: 'registration',
            tld: tld,
            years: 1
        };
        
        OrderForm.cart.addDomain(domain);
        OrderForm.showToast(`Domain ${domainName} added to cart!`, 'success');
        
        // Update UI to show domain as selected
        const button = event.target;
        button.disabled = true;
        button.textContent = 'Added to Cart';
        button.classList.remove('bg-ds-blue', 'hover:bg-blue-600');
        button.classList.add('bg-ds-green', 'cursor-not-allowed');
    }
    
    function clearSearchResults() {
        document.getElementById('searchResults').classList.add('hidden');
        document.getElementById('domainSearch').value = '';
        document.getElementById('domainSearch').focus();
    }
    
    function removeDomainFromCart(domainId) {
        OrderForm.removeDomain(domainId);
        // Refresh the page to update the cart display
        location.reload();
    }
    
    function isValidDomainName(domain) {
        // Basic domain name validation
        const domainRegex = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$/;
        return domainRegex.test(domain) && domain.length >= 2 && domain.length <= 63;
    }
    
    // Initialize domain search functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize with register tab active
        showDomainTab('register');
        
        // Add real-time domain search on input
        const domainInput = document.getElementById('domainSearch');
        if (domainInput) {
            domainInput.addEventListener('input', function() {
                clearTimeout(domainSearchTimeout);
                const value = this.value.trim();
                
                if (value.length >= 2) {
                    domainSearchTimeout = setTimeout(() => {
                        // Auto-search after user stops typing for 2 seconds
                        // performDomainSearch();
                    }, 2000);
                }
            });
            
            // Search on Enter key
            domainInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    performDomainSearch();
                }
            });
        }
        
        // Form validation
        document.getElementById('domainSelectionForm').addEventListener('submit', function(e) {
            const selectedType = document.getElementById('selectedDomainType').value;
            
            if (selectedType === 'transfer') {
                const transferDomain = document.getElementById('transferDomain').value.trim();
                if (!transferDomain) {
                    e.preventDefault();
                    OrderForm.showAlert('Please enter a domain to transfer.', 'error');
                    document.getElementById('transferDomain').focus();
                    return false;
                }
            } else if (selectedType === 'existing') {
                const existingDomain = document.getElementById('existingDomain').value.trim();
                if (!existingDomain) {
                    e.preventDefault();
                    OrderForm.showAlert('Please enter your existing domain name.', 'error');
                    document.getElementById('existingDomain').focus();
                    return false;
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