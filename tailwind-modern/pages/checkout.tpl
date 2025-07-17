{*
 * Checkout Page (Step 5)
 * Final checkout with payment processing and comprehensive error handling
 * Full WHMCS integration with secure payment processing
 *
 * WHMCS Variables:
 * $paymentmethods - Available payment methods
 * $clientdetails - Client account information
 * $invoiceid - Generated invoice ID
 * $total - Order total amount
 * $gateways - Payment gateway configurations
 * $accepttos - Terms of service acceptance requirement
 * $customfields - Custom fields for account creation
 *}

{assign var="currentStep" value=5}
{assign var="pageTitle" value="Complete Your Order"}
{assign var="bodyContent"}

<form method="post" action="cart.php" id="checkoutForm" novalidate>
    <input type="hidden" name="a" value="checkout">
    <input type="hidden" name="token" value="{$token}">
    {if $invoiceid}<input type="hidden" name="invoiceid" value="{$invoiceid}">{/if}
    
    {* Page Header *}
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Complete Your Order</h1>
        <p class="text-gray-400 text-lg">Choose your payment method and complete your secure purchase</p>
    </div>
    
    {* Account Information Section *}
    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
        <h3 class="text-xl font-semibold text-white mb-6 flex items-center">
            <svg class="w-6 h-6 text-ds-blue mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
            </svg>
            Account Information
        </h3>
        
        {if !$loggedin}
            {* Account Type Selection *}
            <div class="mb-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <label class="relative cursor-pointer">
                        <input type="radio" 
                               name="accounttype" 
                               value="existing" 
                               class="sr-only peer"
                               onchange="toggleAccountType('existing')">
                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-blue peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200">
                            <div class="flex items-center space-x-3">
                                <svg class="w-6 h-6 text-ds-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"></path>
                                </svg>
                                <div>
                                    <h4 class="font-medium text-white">Existing Customer</h4>
                                    <p class="text-sm text-gray-400">Sign in to your account</p>
                                </div>
                            </div>
                        </div>
                    </label>
                    
                    <label class="relative cursor-pointer">
                        <input type="radio" 
                               name="accounttype" 
                               value="new" 
                               class="sr-only peer"
                               checked
                               onchange="toggleAccountType('new')">
                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-blue peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200">
                            <div class="flex items-center space-x-3">
                                <svg class="w-6 h-6 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                                </svg>
                                <div>
                                    <h4 class="font-medium text-white">New Customer</h4>
                                    <p class="text-sm text-gray-400">Create a new account</p>
                                </div>
                            </div>
                        </div>
                    </label>
                </div>
            </div>
            
            {* Existing Customer Login *}
            <div id="existingCustomer" class="hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <div>
                        <label for="loginEmail" class="block text-sm font-medium text-gray-300 mb-2">
                            Email Address <span class="text-red-400">*</span>
                        </label>
                        <input type="email" 
                               id="loginEmail" 
                               name="loginemail"
                               class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                               placeholder="your@email.com"
                               autocomplete="email">
                    </div>
                    <div>
                        <label for="loginPassword" class="block text-sm font-medium text-gray-300 mb-2">
                            Password <span class="text-red-400">*</span>
                        </label>
                        <div class="relative">
                            <input type="password" 
                                   id="loginPassword" 
                                   name="loginpassword"
                                   class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent pr-12"
                                   placeholder="Enter your password"
                                   autocomplete="current-password">
                            <button type="button" 
                                    onclick="togglePasswordVisibility('loginPassword')"
                                    class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-gray-300"
                                    aria-label="Toggle password visibility">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="flex items-center justify-between">
                    <a href="{$WEB_ROOT}/pwreset.php" class="text-ds-blue hover:text-blue-400 text-sm underline">
                        Forgot your password?
                    </a>
                    <button type="button" 
                            onclick="validateLogin()"
                            class="bg-ds-blue hover:bg-blue-600 text-white px-6 py-2 rounded-lg font-medium transition-colors duration-200">
                        Sign In
                    </button>
                </div>
            </div>
            
            {* New Customer Registration *}
            <div id="newCustomer">
                <div class="space-y-6">
                    {* Personal Information *}
                    <div>
                        <h4 class="text-lg font-medium text-white mb-4">Personal Information</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="firstName" class="block text-sm font-medium text-gray-300 mb-2">
                                    First Name <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       id="firstName" 
                                       name="firstname"
                                       required
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       placeholder="John"
                                       autocomplete="given-name">
                            </div>
                            <div>
                                <label for="lastName" class="block text-sm font-medium text-gray-300 mb-2">
                                    Last Name <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       id="lastName" 
                                       name="lastname"
                                       required
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       placeholder="Doe"
                                       autocomplete="family-name">
                            </div>
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-300 mb-2">
                                    Email Address <span class="text-red-400">*</span>
                                </label>
                                <input type="email" 
                                       id="email" 
                                       name="email"
                                       required
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       placeholder="john@example.com"
                                       autocomplete="email">
                            </div>
                            <div>
                                <label for="phonenumber" class="block text-sm font-medium text-gray-300 mb-2">
                                    Phone Number <span class="text-red-400">*</span>
                                </label>
                                <input type="tel" 
                                       id="phonenumber" 
                                       name="phonenumber"
                                       required
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       placeholder="+1 (555) 123-4567"
                                       autocomplete="tel">
                            </div>
                        </div>
                    </div>
                    
                    {* Address Information *}
                    <div>
                        <h4 class="text-lg font-medium text-white mb-4">Billing Address</h4>
                        <div class="space-y-4">
                            <div>
                                <label for="address1" class="block text-sm font-medium text-gray-300 mb-2">
                                    Street Address <span class="text-red-400">*</span>
                                </label>
                                <input type="text" 
                                       id="address1" 
                                       name="address1"
                                       required
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       placeholder="123 Main Street"
                                       autocomplete="street-address">
                            </div>
                            <div>
                                <label for="address2" class="block text-sm font-medium text-gray-300 mb-2">
                                    Address Line 2 <span class="text-gray-500">(Optional)</span>
                                </label>
                                <input type="text" 
                                       id="address2" 
                                       name="address2"
                                       class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                       placeholder="Apartment, suite, etc."
                                       autocomplete="address-line2">
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div>
                                    <label for="city" class="block text-sm font-medium text-gray-300 mb-2">
                                        City <span class="text-red-400">*</span>
                                    </label>
                                    <input type="text" 
                                           id="city" 
                                           name="city"
                                           required
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                           placeholder="New York"
                                           autocomplete="address-level2">
                                </div>
                                <div>
                                    <label for="state" class="block text-sm font-medium text-gray-300 mb-2">
                                        State/Province <span class="text-red-400">*</span>
                                    </label>
                                    <input type="text" 
                                           id="state" 
                                           name="state"
                                           required
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                           placeholder="NY"
                                           autocomplete="address-level1">
                                </div>
                                <div>
                                    <label for="postcode" class="block text-sm font-medium text-gray-300 mb-2">
                                        ZIP/Postal Code <span class="text-red-400">*</span>
                                    </label>
                                    <input type="text" 
                                           id="postcode" 
                                           name="postcode"
                                           required
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                           placeholder="10001"
                                           autocomplete="postal-code">
                                </div>
                            </div>
                            <div>
                                <label for="country" class="block text-sm font-medium text-gray-300 mb-2">
                                    Country <span class="text-red-400">*</span>
                                </label>
                                <select name="country" 
                                        id="country"
                                        required
                                        class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                                        autocomplete="country">
                                    <option value="">Select Country</option>
                                    <option value="US" selected>United States</option>
                                    <option value="CA">Canada</option>
                                    <option value="GB">United Kingdom</option>
                                    <option value="AU">Australia</option>
                                    <option value="DE">Germany</option>
                                    <option value="FR">France</option>
                                    <option value="IT">Italy</option>
                                    <option value="ES">Spain</option>
                                    <option value="NL">Netherlands</option>
                                    <option value="BR">Brazil</option>
                                    <option value="JP">Japan</option>
                                    <option value="CN">China</option>
                                    <option value="IN">India</option>
                                    {* Add more countries as needed *}
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    {* Account Security *}
                    <div>
                        <h4 class="text-lg font-medium text-white mb-4">Account Security</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-300 mb-2">
                                    Password <span class="text-red-400">*</span>
                                </label>
                                <div class="relative">
                                    <input type="password" 
                                           id="password" 
                                           name="password"
                                           required
                                           minlength="8"
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent pr-12"
                                           placeholder="Minimum 8 characters"
                                           autocomplete="new-password">
                                    <button type="button" 
                                            onclick="togglePasswordVisibility('password')"
                                            class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-gray-300"
                                            aria-label="Toggle password visibility">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                        </svg>
                                    </button>
                                </div>
                                <div id="password-strength" class="mt-2 text-xs"></div>
                            </div>
                            <div>
                                <label for="password2" class="block text-sm font-medium text-gray-300 mb-2">
                                    Confirm Password <span class="text-red-400">*</span>
                                </label>
                                <div class="relative">
                                    <input type="password" 
                                           id="password2" 
                                           name="password2"
                                           required
                                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent pr-12"
                                           placeholder="Confirm your password"
                                           autocomplete="new-password">
                                    <button type="button" 
                                            onclick="togglePasswordVisibility('password2')"
                                            class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-gray-300"
                                            aria-label="Toggle password visibility">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {else}
            {* Logged in user info *}
            <div class="flex items-center justify-between p-4 bg-gray-800 rounded-lg">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-ds-blue rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <div>
                        <h4 class="font-medium text-white">{$clientdetails.firstname} {$clientdetails.lastname}</h4>
                        <p class="text-sm text-gray-400">{$clientdetails.email}</p>
                    </div>
                </div>
                <a href="{$WEB_ROOT}/logout.php" class="text-ds-blue hover:text-blue-400 text-sm underline">
                    Not you? Sign out
                </a>
            </div>
        {/if}
    </div>
    
    {* Payment Method Section *}
    <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
        <h3 class="text-xl font-semibold text-white mb-6 flex items-center">
            <svg class="w-6 h-6 text-ds-green mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
            </svg>
            Payment Method
        </h3>
        
        {if $paymentmethods}
            <div class="space-y-4 mb-6">
                {foreach from=$paymentmethods item=method name=payments}
                    <label class="relative cursor-pointer">
                        <input type="radio" 
                               name="paymentmethod" 
                               value="{$method.sysname}" 
                               class="sr-only peer payment-method-radio"
                               {if $smarty.foreach.payments.first}checked{/if}
                               onchange="selectPaymentMethod('{$method.sysname}', '{$method.type}')">
                        <div class="p-4 border-2 border-gray-600 rounded-lg peer-checked:border-ds-green peer-checked:bg-gray-800 hover:border-gray-500 transition-all duration-200">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center space-x-3">
                                    {if $method.type == 'CC'}
                                        <svg class="w-8 h-8 text-ds-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                                        </svg>
                                    {elseif $method.type == 'Offline'}
                                        <svg class="w-8 h-8 text-ds-purple" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                        </svg>
                                    {else}
                                        <svg class="w-8 h-8 text-ds-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
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
        
        {* Credit Card Details (shown when CC payment method is selected) *}
        <div id="creditCardDetails" class="space-y-4">
            <h4 class="text-lg font-medium text-white mb-4">Credit Card Information</h4>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="md:col-span-2">
                    <label for="ccnumber" class="block text-sm font-medium text-gray-300 mb-2">
                        Card Number <span class="text-red-400">*</span>
                    </label>
                    <input type="text" 
                           id="ccnumber" 
                           name="ccnumber"
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                           placeholder="1234 5678 9012 3456"
                           autocomplete="cc-number"
                           inputmode="numeric">
                </div>
                <div>
                    <label for="ccexpirydate" class="block text-sm font-medium text-gray-300 mb-2">
                        Expiry Date <span class="text-red-400">*</span>
                    </label>
                    <input type="text" 
                           id="ccexpirydate" 
                           name="ccexpirydate"
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                           placeholder="MM/YY"
                           autocomplete="cc-exp"
                           inputmode="numeric"
                           maxlength="5">
                </div>
                <div>
                    <label for="cvccode" class="block text-sm font-medium text-gray-300 mb-2">
                        CVV Code <span class="text-red-400">*</span>
                    </label>
                    <input type="text" 
                           id="cvccode" 
                           name="cvccode"
                           class="w-full bg-gray-800 border border-gray-600 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ds-blue focus:border-transparent"
                           placeholder="123"
                           autocomplete="cc-csc"
                           inputmode="numeric"
                           maxlength="4">
                </div>
            </div>
            
            {* Security Notice *}
            <div class="bg-green-500/10 border border-green-500/20 rounded-lg p-4">
                <div class="flex items-start">
                    <svg class="w-5 h-5 text-green-400 mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                    </svg>
                    <div class="text-sm">
                        <h5 class="font-medium text-green-300 mb-1">Secure Payment</h5>
                        <p class="text-green-200">
                            Your payment information is encrypted and secure. We never store your credit card details.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    {* Terms and Conditions *}
    {if $accepttos}
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
            <h3 class="text-xl font-semibold text-white mb-4">Terms and Conditions</h3>
            <div class="space-y-4">
                <label class="flex items-start space-x-3 cursor-pointer">
                    <input type="checkbox" 
                           name="accepttos" 
                           value="1" 
                           required
                           class="checkbox-custom mt-1">
                    <div class="text-sm text-gray-300">
                        I have read and agree to the 
                        <a href="{$WEB_ROOT}/terms.php" target="_blank" class="text-ds-blue hover:text-blue-400 underline">Terms of Service</a>
                        and 
                        <a href="{$WEB_ROOT}/privacy.php" target="_blank" class="text-ds-blue hover:text-blue-400 underline">Privacy Policy</a>
                        <span class="text-red-400">*</span>
                    </div>
                </label>
                
                <label class="flex items-start space-x-3 cursor-pointer">
                    <input type="checkbox" 
                           name="marketing" 
                           value="1" 
                           class="checkbox-custom mt-1">
                    <div class="text-sm text-gray-300">
                        I would like to receive promotional emails and updates about new products and services
                    </div>
                </label>
            </div>
        </div>
    {/if}
    
    {* Submit Button *}
    <div class="flex justify-between items-center pt-8 border-t border-gray-700">
        <a href="cart.php?a=view" 
           class="inline-flex items-center px-6 py-3 bg-gray-700 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors duration-200">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            Back to Summary
        </a>
        
        <button type="submit" 
                id="submitOrderBtn"
                class="inline-flex items-center px-8 py-3 btn-primary text-gray-900 rounded-lg font-bold transition-all duration-300 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            Complete Order
        </button>
    </div>
</form>

{assign var="additionalFooter"}
<script>
    // Checkout form functionality
    let selectedPaymentMethod = '';
    let selectedPaymentType = '';
    
    function toggleAccountType(type) {
        const existingDiv = document.getElementById('existingCustomer');
        const newDiv = document.getElementById('newCustomer');
        
        if (type === 'existing') {
            existingDiv.classList.remove('hidden');
            newDiv.classList.add('hidden');
            
            // Make existing customer fields required
            existingDiv.querySelectorAll('input').forEach(input => {
                input.required = true;
            });
            newDiv.querySelectorAll('input[required]').forEach(input => {
                input.required = false;
            });
        } else {
            existingDiv.classList.add('hidden');
            newDiv.classList.remove('hidden');
            
            // Make new customer fields required
            existingDiv.querySelectorAll('input').forEach(input => {
                input.required = false;
            });
            newDiv.querySelectorAll('input[data-required="true"], input[required]').forEach(input => {
                input.required = true;
            });
        }
    }
    
    function selectPaymentMethod(methodName, methodType) {
        selectedPaymentMethod = methodName;
        selectedPaymentType = methodType;
        
        const ccDetails = document.getElementById('creditCardDetails');
        
        if (methodType === 'CC') {
            ccDetails.classList.remove('hidden');
            ccDetails.querySelectorAll('input').forEach(input => {
                input.required = true;
            });
        } else {
            ccDetails.classList.add('hidden');
            ccDetails.querySelectorAll('input').forEach(input => {
                input.required = false;
            });
        }
    }
    
    function togglePasswordVisibility(inputId) {
        const input = document.getElementById(inputId);
        const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
        input.setAttribute('type', type);
        
        const button = input.nextElementSibling.querySelector('svg');
        if (type === 'text') {
            button.innerHTML = `
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"></path>
            `;
        } else {
            button.innerHTML = `
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
            `;
        }
    }
    
    function validateLogin() {
        const email = document.getElementById('loginEmail').value;
        const password = document.getElementById('loginPassword').value;
        
        if (!email || !password) {
            OrderForm.showAlert('Please enter both email and password.', 'error');
            return;
        }
        
        if (!OrderForm.utils.validateEmail(email)) {
            OrderForm.showAlert('Please enter a valid email address.', 'error');
            return;
        }
        
        // Show loading state
        OrderForm.showFormLoading('Signing you in...', 'Please wait while we verify your credentials');
        
        // Simulate login request
        setTimeout(() => {
            OrderForm.hideFormLoading();
            OrderForm.showAlert('Login successful! Redirecting...', 'success');
            
            // In real implementation, submit login form
            setTimeout(() => {
                window.location.reload();
            }, 1500);
        }, 2000);
    }
    
    function validatePasswordStrength(password) {
        const strengthIndicator = document.getElementById('password-strength');
        if (!strengthIndicator) return;
        
        let strength = 0;
        let feedback = [];
        
        if (password.length >= 8) strength++;
        else feedback.push('At least 8 characters');
        
        if (/[a-z]/.test(password)) strength++;
        else feedback.push('Lowercase letter');
        
        if (/[A-Z]/.test(password)) strength++;
        else feedback.push('Uppercase letter');
        
        if (/[0-9]/.test(password)) strength++;
        else feedback.push('Number');
        
        if (/[^a-zA-Z0-9]/.test(password)) strength++;
        else feedback.push('Special character');
        
        const strengthLevels = ['Very Weak', 'Weak', 'Fair', 'Good', 'Strong'];
        const strengthColors = ['text-red-400', 'text-orange-400', 'text-yellow-400', 'text-blue-400', 'text-green-400'];
        
        strengthIndicator.className = `mt-2 text-xs ${strengthColors[strength - 1] || 'text-gray-400'}`;
        
        if (password.length === 0) {
            strengthIndicator.textContent = '';
        } else if (strength < 3) {
            strengthIndicator.textContent = `${strengthLevels[strength - 1] || 'Very Weak'}: Missing ${feedback.join(', ')}`;
        } else {
            strengthIndicator.textContent = `Password strength: ${strengthLevels[strength - 1]}`;
        }
    }
    
    // Initialize checkout form
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize with new customer by default
        toggleAccountType('new');
        
        // Initialize payment method
        const firstPaymentMethod = document.querySelector('.payment-method-radio');
        if (firstPaymentMethod) {
            const methodName = firstPaymentMethod.value;
            const methodType = firstPaymentMethod.closest('label').querySelector('svg').closest('div').textContent.includes('Credit') ? 'CC' : 'Other';
            selectPaymentMethod(methodName, methodType);
        }
        
        // Password strength checking
        const passwordInput = document.getElementById('password');
        if (passwordInput) {
            passwordInput.addEventListener('input', function() {
                validatePasswordStrength(this.value);
            });
        }
        
        // Password confirmation
        const password2Input = document.getElementById('password2');
        if (password2Input && passwordInput) {
            password2Input.addEventListener('input', function() {
                if (this.value && this.value !== passwordInput.value) {
                    this.setCustomValidity('Passwords do not match');
                    this.classList.add('border-red-500');
                } else {
                    this.setCustomValidity('');
                    this.classList.remove('border-red-500');
                }
            });
        }
        
        // Form submission handling
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate form
            const validation = OrderForm.validation.validateForm(this);
            if (!validation.isValid) {
                OrderForm.showAlert('Please fill in all required fields correctly.', 'error');
                // Focus first invalid field
                const firstInvalid = this.querySelector('.border-red-500, :invalid');
                if (firstInvalid) firstInvalid.focus();
                return false;
            }
            
            // Check TOS acceptance if required
            const tosCheckbox = this.querySelector('input[name="accepttos"]');
            if (tosCheckbox && !tosCheckbox.checked) {
                OrderForm.showAlert('Please accept the Terms of Service to continue.', 'error');
                tosCheckbox.focus();
                return false;
            }
            
            // Show processing state
            const submitBtn = document.getElementById('submitOrderBtn');
            OrderForm.showButtonLoading(submitBtn, 'Processing Order...');
            OrderForm.showFormLoading('Processing your order...', 'Please do not close this window or refresh the page');
            
            // Simulate order processing
            setTimeout(() => {
                // In real implementation, submit the form
                this.submit();
            }, 3000);
        });
        
        // Auto-format credit card fields
        const ccNumberInput = document.getElementById('ccnumber');
        if (ccNumberInput) {
            ccNumberInput.addEventListener('input', function() {
                let value = this.value.replace(/\s/g, '').replace(/[^0-9]/gi, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                this.value = formattedValue;
            });
        }
        
        const ccExpiryInput = document.getElementById('ccexpirydate');
        if (ccExpiryInput) {
            ccExpiryInput.addEventListener('input', function() {
                let value = this.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                this.value = value;
            });
        }
        
        // CVV validation
        const cvcInput = document.getElementById('cvccode');
        if (cvcInput) {
            cvcInput.addEventListener('input', function() {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        }
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