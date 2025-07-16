{*
 * Step 3: Domain Selection
 * Multi-step wizard - Domain selection and registration page
 * DoubleSpeedHost themed with Tailwind CSS
 *
 * WHMCS Variables:
 * $domainpricing - Domain pricing information
 * $transfertlds - Available TLDs for transfer
 * $registertlds - Available TLDs for registration
 * $incartdomains - Domains already in cart
 *}

{* Set current step for progress indicator *}
{assign var="currentStep" value=3}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Domain - DoubleSpeedHost</title>
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
                <form method="post" action="cart.php" id="domainForm">
                    {* Page Header *}
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold text-white mb-2">Choose Your Domain</h1>
                        <p class="text-gray-400">Register a new domain or use an existing one</p>
                    </div>
                    
                    {* Domain Options Tabs *}
                    <div class="mb-8">
                        <div class="flex border-b border-gray-700">
                            <button type="button" 
                                    onclick="showTab('register')" 
                                    id="registerTab"
                                    class="px-6 py-3 font-medium border-b-2 border-transparent hover:border-ds-blue focus:outline-none tab-button active">
                                Register New Domain
                            </button>
                            <button type="button" 
                                    onclick="showTab('transfer')" 
                                    id="transferTab"
                                    class="px-6 py-3 font-medium border-b-2 border-transparent hover:border-ds-blue focus:outline-none tab-button">
                                Transfer Domain
                            </button>
                            <button type="button" 
                                    onclick="showTab('existing')" 
                                    id="existingTab"
                                    class="px-6 py-3 font-medium border-b-2 border-transparent hover:border-ds-blue focus:outline-none tab-button">
                                Use Existing Domain
                            </button>
                            <button type="button" 
                                    onclick="showTab('subdomain')" 
                                    id="subdomainTab"
                                    class="px-6 py-3 font-medium border-b-2 border-transparent hover:border-ds-blue focus:outline-none tab-button">
                                Free Subdomain
                            </button>
                        </div>
                    </div>
                    
                    {* Register New Domain Tab *}
                    <div id="registerContent" class="tab-content">
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-6">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-green mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9m0 9c-5 0-9-4-9-9s4-9 9-9"></path>
                                </svg>
                                Register a New Domain
                            </h3>
                            
                            {* Domain Search *}
                            <div class="mb-6">
                                <div class="flex space-x-4">
                                    <div class="flex-1">
                                        <input type="text" 
                                               name="domain" 
                                               id="domainSearch"
                                               placeholder="Enter your desired domain name"
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <button type="button" 
                                            onclick="searchDomain()"
                                            class="bg-ds-blue hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                                        Search
                                    </button>
                                </div>
                            </div>
                            
                            {* Popular TLD Options *}
                            {if $domainpricing}
                                <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
                                    {foreach from=$domainpricing item=pricing key=tld}
                                        <label class="relative cursor-pointer group">
                                            <input type="radio" 
                                                   name="domaintype" 
                                                   value="register"
                                                   data-tld="{$tld}"
                                                   data-price="{$pricing.register}"
                                                   class="sr-only peer">
                                            <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-green peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200 text-center">
                                                <div class="font-bold text-white text-lg">.{$tld}</div>
                                                <div class="text-ds-green font-semibold">
                                                    {$selectedCurrency.prefix}{$pricing.register}{$selectedCurrency.suffix}
                                                </div>
                                                <div class="text-xs text-gray-400">/year</div>
                                            </div>
                                        </label>
                                    {/foreach}
                                </div>
                            {/if}
                        </div>
                        
                        {* Domain Search Results (placeholder) *}
                        <div id="searchResults" class="hidden">
                            <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                                <h4 class="text-lg font-semibold text-white mb-4">Search Results</h4>
                                <div id="resultsContainer" class="space-y-3">
                                    {* Results will be populated via JavaScript/AJAX *}
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    {* Transfer Domain Tab *}
                    <div id="transferContent" class="tab-content hidden">
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-blue mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                                </svg>
                                Transfer Your Domain
                            </h3>
                            
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-300 mb-2">Domain Name</label>
                                    <input type="text" 
                                           name="transferdomain"
                                           placeholder="example.com"
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-medium text-gray-300 mb-2">Authorization Code (EPP Code)</label>
                                    <input type="text" 
                                           name="eppcode"
                                           placeholder="Enter EPP/Auth code"
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    <p class="mt-1 text-xs text-gray-400">Required for most domain transfers. Contact your current registrar if you don't have this.</p>
                                </div>
                                
                                {* Transfer Pricing *}
                                {if $transfertlds}
                                    <div class="bg-gray-800 rounded-lg p-4">
                                        <h5 class="font-medium text-white mb-3">Transfer Pricing</h5>
                                        <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
                                            {foreach from=$transfertlds item=pricing key=tld}
                                                <div class="text-center p-2 bg-gray-700 rounded">
                                                    <div class="font-bold text-white">.{$tld}</div>
                                                    <div class="text-ds-green text-sm">
                                                        {$selectedCurrency.prefix}{$pricing.transfer}{$selectedCurrency.suffix}
                                                    </div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                    
                    {* Use Existing Domain Tab *}
                    <div id="existingContent" class="tab-content hidden">
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-purple mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"></path>
                                </svg>
                                Use Your Existing Domain
                            </h3>
                            
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-300 mb-2">Domain Name</label>
                                    <input type="text" 
                                           name="existingdomain"
                                           placeholder="yourdomain.com"
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                </div>
                                
                                <div class="bg-blue-900/30 border border-blue-700 rounded-lg p-4">
                                    <div class="flex items-start">
                                        <svg class="w-5 h-5 text-blue-400 mr-3 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                        </svg>
                                        <div>
                                            <h4 class="text-blue-300 font-medium mb-1">DNS Configuration Required</h4>
                                            <p class="text-blue-200 text-sm">
                                                You'll need to point your domain's nameservers to our hosting servers. 
                                                We'll provide you with the nameserver information after your order is complete.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    {* Free Subdomain Tab *}
                    <div id="subdomainContent" class="tab-content hidden">
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6">
                            <h3 class="text-lg font-semibold text-white mb-4 flex items-center">
                                <svg class="w-5 h-5 text-ds-green mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"></path>
                                </svg>
                                Free Subdomain
                            </h3>
                            
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-300 mb-2">Choose Your Subdomain</label>
                                    <div class="flex">
                                        <input type="text" 
                                               name="subdomain"
                                               placeholder="yoursite"
                                               class="flex-1 bg-gray-800 border border-gray-600 rounded-l-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                        <select name="subdomaintld" 
                                                class="bg-gray-800 border border-gray-600 border-l-0 rounded-r-lg px-4 py-3 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                            <option value="doublespeedhost.com">.doublespeedhost.com</option>
                                            <option value="dshost.net">.dshost.net</option>
                                            <option value="freehosting.club">.freehosting.club</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="bg-green-900/30 border border-green-700 rounded-lg p-4">
                                    <div class="flex items-start">
                                        <svg class="w-5 h-5 text-green-400 mr-3 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                        </svg>
                                        <div>
                                            <h4 class="text-green-300 font-medium mb-1">Free Subdomain Included</h4>
                                            <p class="text-green-200 text-sm">
                                                Get started immediately with a free subdomain. You can always upgrade to a custom domain later.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    {* Navigation Buttons *}
                    <div class="flex justify-between mt-8">
                        <a href="cart.php?a=confproduct" 
                           class="bg-gray-700 hover:bg-gray-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                            ← Back to Configuration
                        </a>
                        <button type="submit" 
                                name="a" 
                                value="checkout"
                                class="bg-gradient-to-r from-ds-green to-ds-blue hover:from-ds-blue hover:to-ds-purple text-gray-900 font-bold px-8 py-3 rounded-lg transition-all duration-300 transform hover:scale-105">
                            Continue to Summary →
                        </button>
                    </div>
                    
                    {* Hidden form fields *}
                    <input type="hidden" name="domaintype" id="selectedDomainType" value="register">
                    <input type="hidden" name="domainsregperiod" value="1">
                </form>
            </div>
            
            {* Sidebar Summary *}
            <div class="lg:col-span-1">
                {include file="sidebar-summary.tpl" 
                         products=$cart.products 
                         domain=$cart.domain 
                         subtotal=$cart.subtotal 
                         total=$cart.total 
                         currency=$selectedCurrency}
            </div>
        </div>
    </div>
    
    <script>
        function showTab(tabName) {
            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.add('hidden');
            });
            
            // Remove active class from all tabs
            document.querySelectorAll('.tab-button').forEach(button => {
                button.classList.remove('active', 'border-ds-blue', 'text-ds-blue');
                button.classList.add('text-gray-400');
            });
            
            // Show selected tab content
            document.getElementById(tabName + 'Content').classList.remove('hidden');
            
            // Add active class to selected tab
            const activeTab = document.getElementById(tabName + 'Tab');
            activeTab.classList.add('active', 'border-ds-blue', 'text-ds-blue');
            activeTab.classList.remove('text-gray-400');
            
            // Update hidden form field
            document.getElementById('selectedDomainType').value = tabName;
        }
        
        function searchDomain() {
            const domainName = document.getElementById('domainSearch').value;
            if (!domainName) {
                alert('Please enter a domain name to search.');
                return;
            }
            
            // Show loading state
            const searchResults = document.getElementById('searchResults');
            const resultsContainer = document.getElementById('resultsContainer');
            
            searchResults.classList.remove('hidden');
            resultsContainer.innerHTML = '<div class="text-center py-4"><div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-ds-blue"></div><div class="mt-2 text-gray-400">Searching domains...</div></div>';
            
            // Simulate domain search (in real implementation, this would be an AJAX call)
            setTimeout(() => {
                const mockResults = [
                    { name: domainName + '.com', available: true, price: '12.99' },
                    { name: domainName + '.net', available: true, price: '14.99' },
                    { name: domainName + '.org', available: false, price: '13.99' },
                    { name: domainName + '.io', available: true, price: '59.99' }
                ];
                
                displaySearchResults(mockResults);
            }, 1500);
        }
        
        function displaySearchResults(results) {
            const resultsContainer = document.getElementById('resultsContainer');
            let html = '';
            
            results.forEach(result => {
                html += `
                    <div class="flex items-center justify-between p-4 border border-gray-600 rounded-lg ${result.available ? 'bg-gray-800' : 'bg-gray-800/50'}">
                        <div class="flex items-center">
                            <div class="w-3 h-3 rounded-full mr-3 ${result.available ? 'bg-ds-green' : 'bg-red-500'}"></div>
                            <span class="font-medium ${result.available ? 'text-white' : 'text-gray-500'}">${result.name}</span>
                        </div>
                        <div class="flex items-center space-x-4">
                            <span class="text-ds-green font-semibold">$${result.price}/year</span>
                            ${result.available ? 
                                `<button type="button" onclick="selectDomain('${result.name}', '${result.price}')" class="bg-ds-blue hover:bg-blue-600 text-white px-4 py-2 rounded font-medium transition-colors duration-200">Add</button>` :
                                `<span class="text-red-400 text-sm">Unavailable</span>`
                            }
                        </div>
                    </div>
                `;
            });
            
            resultsContainer.innerHTML = html;
        }
        
        function selectDomain(domainName, price) {
            document.getElementById('domainSearch').value = domainName;
            // In real implementation, add domain to cart
            alert(`Domain ${domainName} selected for $${price}/year`);
        }
        
        // Initialize with register tab active
        document.addEventListener('DOMContentLoaded', function() {
            showTab('register');
        });
    </script>
</body>
</html>