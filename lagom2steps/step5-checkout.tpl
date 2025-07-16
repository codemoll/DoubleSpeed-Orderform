{*
 * Step 5: Checkout
 * Multi-step wizard - Final checkout and payment page
 * DoubleSpeedHost themed with Tailwind CSS
 *
 * WHMCS Variables:
 * $paymentmethods - Available payment methods
 * $clientdetails - Client account information
 * $invoiceid - Generated invoice ID
 * $total - Order total amount
 * $gateways - Payment gateway configurations
 *}

{* Set current step for progress indicator *}
{assign var="currentStep" value=5}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - DoubleSpeedHost</title>
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
                <form method="post" action="cart.php?a=checkout" id="checkoutForm">
                    {* Page Header *}
                    <div class="mb-8">
                        <h1 class="text-3xl font-bold text-white mb-2">Complete Your Order</h1>
                        <p class="text-gray-400">Choose your payment method and complete your purchase</p>
                    </div>
                    
                    {* Account Information Section *}
                    {if !$loggedin}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                                <svg class="w-6 h-6 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                                Account Information
                            </h3>
                            
                            {* Login or Create Account Tabs *}
                            <div class="mb-6">
                                <div class="flex border-b border-gray-700">
                                    <button type="button" 
                                            onclick="showAccountTab('existing')" 
                                            id="existingAccountTab"
                                            class="px-4 py-2 font-medium border-b-2 border-transparent hover:border-ds-blue focus:outline-none tab-button active">
                                        Existing Customer
                                    </button>
                                    <button type="button" 
                                            onclick="showAccountTab('new')" 
                                            id="newAccountTab"
                                            class="px-4 py-2 font-medium border-b-2 border-transparent hover:border-ds-blue focus:outline-none tab-button">
                                        New Customer
                                    </button>
                                </div>
                            </div>
                            
                            {* Existing Customer Login *}
                            <div id="existingAccountContent" class="account-content">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">Email Address</label>
                                        <input type="email" 
                                               name="loginemail" 
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">Password</label>
                                        <input type="password" 
                                               name="loginpassword" 
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <button type="button" 
                                            onclick="loginCustomer()"
                                            class="bg-ds-blue hover:bg-blue-600 text-white px-6 py-2 rounded-lg font-medium transition-colors duration-200">
                                        Login
                                    </button>
                                    <a href="/password/reset" class="ml-4 text-ds-blue hover:text-blue-400 text-sm underline">
                                        Forgot Password?
                                    </a>
                                </div>
                            </div>
                            
                            {* New Customer Registration *}
                            <div id="newAccountContent" class="account-content hidden">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            First Name <span class="text-red-400">*</span>
                                        </label>
                                        <input type="text" 
                                               name="firstname" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Last Name <span class="text-red-400">*</span>
                                        </label>
                                        <input type="text" 
                                               name="lastname" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Email Address <span class="text-red-400">*</span>
                                        </label>
                                        <input type="email" 
                                               name="email" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Phone Number <span class="text-red-400">*</span>
                                        </label>
                                        <input type="tel" 
                                               name="phonenumber" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Password <span class="text-red-400">*</span>
                                        </label>
                                        <input type="password" 
                                               name="password" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Confirm Password <span class="text-red-400">*</span>
                                        </label>
                                        <input type="password" 
                                               name="password2" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div class="md:col-span-2">
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Company Name
                                        </label>
                                        <input type="text" 
                                               name="companyname" 
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div class="md:col-span-2">
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Address <span class="text-red-400">*</span>
                                        </label>
                                        <input type="text" 
                                               name="address1" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            City <span class="text-red-400">*</span>
                                        </label>
                                        <input type="text" 
                                               name="city" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            State/Province <span class="text-red-400">*</span>
                                        </label>
                                        <input type="text" 
                                               name="state" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            ZIP/Postal Code <span class="text-red-400">*</span>
                                        </label>
                                        <input type="text" 
                                               name="postcode" 
                                               required
                                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-300 mb-2">
                                            Country <span class="text-red-400">*</span>
                                        </label>
                                        <select name="country" 
                                                required
                                                class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                                            <option value="">Select Country</option>
                                            <option value="US">United States</option>
                                            <option value="CA">Canada</option>
                                            <option value="GB">United Kingdom</option>
                                            <option value="AU">Australia</option>
                                            {* Add more countries as needed *}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {else}
                        {* Logged in user info *}
                        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                            <h3 class="text-xl font-semibold text-white mb-4">Account Information</h3>
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-white font-medium">{$clientdetails.firstname} {$clientdetails.lastname}</p>
                                    <p class="text-gray-400">{$clientdetails.email}</p>
                                </div>
                                <a href="logout.php" class="text-ds-blue hover:text-blue-400 text-sm underline">
                                    Not you? Logout
                                </a>
                            </div>
                        </div>
                    {/if}
                    
                    {* Payment Method Section *}
                    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                        <h3 class="text-xl font-semibold text-white mb-4 flex items-center">
                            <svg class="w-6 h-6 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                            </svg>
                            Payment Method
                        </h3>
                        
                        {if $paymentmethods}
                            <div class="space-y-4">
                                {foreach from=$paymentmethods item=method}
                                    <label class="relative cursor-pointer">
                                        <input type="radio" 
                                               name="paymentmethod" 
                                               value="{$method.sysname}" 
                                               class="sr-only peer"
                                               {if $method@first}checked{/if}>
                                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-green peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200">
                                            <div class="flex items-center justify-between">
                                                <div class="flex items-center">
                                                    {if $method.type == 'CC'}
                                                        <svg class="w-8 h-8 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                                                        </svg>
                                                    {elseif $method.type == 'Offline'}
                                                        <svg class="w-8 h-8 text-ds-purple mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                                        </svg>
                                                    {else}
                                                        <svg class="w-8 h-8 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                                        </svg>
                                                    {/if}
                                                    <div>
                                                        <h4 class="font-medium text-white">{$method.name}</h4>
                                                        {if $method.description}
                                                            <p class="text-sm text-gray-400">{$method.description}</p>
                                                        {/if}
                                                    </div>
                                                </div>
                                                
                                                {if $method.fee > 0}
                                                    <div class="text-right">
                                                        <span class="text-sm text-gray-400">Processing Fee:</span>
                                                        <div class="text-ds-green font-medium">
                                                            +{$selectedCurrency.prefix}{$method.fee}{$selectedCurrency.suffix}
                                                        </div>
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>
                                    </label>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                    
                    {* Credit Card Details (shown when CC payment method selected) *}
                    <div id="creditCardDetails" class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8 hidden">
                        <h3 class="text-xl font-semibold text-white mb-4">Credit Card Information</h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="md:col-span-2">
                                <label class="block text-sm font-medium text-gray-300 mb-2">
                                    Card Number <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       name="ccnumber" 
                                       placeholder="1234 5678 9012 3456"
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-300 mb-2">
                                    Expiry Date <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       name="ccexpirydate" 
                                       placeholder="MM/YY"
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-300 mb-2">
                                    CVV <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       name="cccvv" 
                                       placeholder="123"
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                            </div>
                            <div class="md:col-span-2">
                                <label class="block text-sm font-medium text-gray-300 mb-2">
                                    Cardholder Name <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       name="ccname" 
                                       placeholder="John Doe"
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent">
                            </div>
                        </div>
                        
                        <div class="mt-4 flex items-center justify-center space-x-4 text-gray-400">
                            <span class="text-sm">We accept:</span>
                            <div class="flex space-x-2">
                                <span class="text-xs px-2 py-1 bg-gray-800 rounded">VISA</span>
                                <span class="text-xs px-2 py-1 bg-gray-800 rounded">MasterCard</span>
                                <span class="text-xs px-2 py-1 bg-gray-800 rounded">AMEX</span>
                                <span class="text-xs px-2 py-1 bg-gray-800 rounded">Discover</span>
                            </div>
                        </div>
                    </div>
                    
                    {* Security & SSL Badge *}
                    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
                        <div class="flex items-center justify-center space-x-6">
                            <div class="flex items-center">
                                <svg class="w-8 h-8 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                                </svg>
                                <div>
                                    <div class="text-white font-medium">256-bit SSL Encryption</div>
                                    <div class="text-gray-400 text-sm">Your data is secure</div>
                                </div>
                            </div>
                            <div class="flex items-center">
                                <svg class="w-8 h-8 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                                </svg>
                                <div>
                                    <div class="text-white font-medium">PCI Compliant</div>
                                    <div class="text-gray-400 text-sm">Secure payments</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    {* Complete Order Button *}
                    <div class="flex justify-between">
                        <a href="cart.php?a=view" 
                           class="bg-gray-700 hover:bg-gray-600 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                            ← Back to Summary
                        </a>
                        <button type="submit" 
                                name="submitorder" 
                                value="true"
                                class="bg-gradient-to-r from-ds-green to-ds-blue hover:from-ds-blue hover:to-ds-purple text-gray-900 font-bold px-12 py-4 rounded-lg text-lg transition-all duration-300 transform hover:scale-105 shadow-lg">
                            Complete Order - {$selectedCurrency.prefix}{$total}{$selectedCurrency.suffix}
                        </button>
                    </div>
                </form>
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
        function showAccountTab(tabName) {
            // Hide all account contents
            document.querySelectorAll('.account-content').forEach(content => {
                content.classList.add('hidden');
            });
            
            // Remove active class from all tabs
            document.querySelectorAll('.tab-button').forEach(button => {
                button.classList.remove('active', 'border-ds-blue', 'text-ds-blue');
                button.classList.add('text-gray-400');
            });
            
            // Show selected tab content
            document.getElementById(tabName + 'AccountContent').classList.remove('hidden');
            
            // Add active class to selected tab
            const activeTab = document.getElementById(tabName + 'AccountTab');
            activeTab.classList.add('active', 'border-ds-blue', 'text-ds-blue');
            activeTab.classList.remove('text-gray-400');
        }
        
        function loginCustomer() {
            const email = document.querySelector('input[name="loginemail"]').value;
            const password = document.querySelector('input[name="loginpassword"]').value;
            
            if (!email || !password) {
                alert('Please enter both email and password.');
                return;
            }
            
            // AJAX login request would go here
            // For now, just show a message
            alert('Login functionality would be implemented here.');
        }
        
        // Show/hide credit card details based on payment method
        document.addEventListener('change', function(e) {
            if (e.target.name === 'paymentmethod') {
                const ccDetails = document.getElementById('creditCardDetails');
                const selectedMethod = e.target.value;
                
                // Check if selected method requires credit card info
                // This would be determined by the payment method configuration
                if (selectedMethod.includes('cc') || selectedMethod.includes('stripe') || selectedMethod.includes('paypal_pro')) {
                    ccDetails.classList.remove('hidden');
                } else {
                    ccDetails.classList.add('hidden');
                }
            }
        });
        
        // Form validation
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate required fields
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.classList.add('border-red-500');
                } else {
                    field.classList.remove('border-red-500');
                }
            });
            
            // Validate password confirmation
            const password = this.querySelector('input[name="password"]');
            const password2 = this.querySelector('input[name="password2"]');
            
            if (password && password2 && password.value !== password2.value) {
                isValid = false;
                password2.classList.add('border-red-500');
                alert('Passwords do not match.');
            }
            
            if (!isValid) {
                alert('Please fill in all required fields correctly.');
                return;
            }
            
            // Show loading state
            const submitButton = this.querySelector('button[type="submit"]');
            submitButton.disabled = true;
            submitButton.innerHTML = 'Processing Order...';
            
            // In real implementation, submit the form
            setTimeout(() => {
                this.submit();
            }, 1000);
        });
        
        // Auto-format credit card number
        document.addEventListener('input', function(e) {
            if (e.target.name === 'ccnumber') {
                let value = e.target.value.replace(/\s/g, '').replace(/[^0-9]/gi, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = formattedValue;
            }
            
            if (e.target.name === 'ccexpirydate') {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                e.target.value = value;
            }
        });
        
        // Initialize with existing customer tab active
        document.addEventListener('DOMContentLoaded', function() {
            showAccountTab('existing');
        });
    </script>
</body>
</html>