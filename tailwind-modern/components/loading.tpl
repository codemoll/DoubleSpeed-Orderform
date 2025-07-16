{*
 * Loading Component
 * Global loading overlay and loading states
 * Provides consistent loading UX across the application
 *}

{* Global loading overlay *}
<div id="global-loading-overlay" 
     class="fixed inset-0 bg-gray-950/75 backdrop-blur-sm z-50 hidden items-center justify-center"
     aria-hidden="true"
     role="status"
     aria-label="Loading">
    <div class="text-center">
        {* Loading spinner *}
        <div class="relative">
            <div class="w-16 h-16 border-4 border-gray-700 border-t-ds-blue rounded-full animate-spin mx-auto"></div>
            <div class="absolute inset-0 w-16 h-16 border-4 border-transparent border-r-ds-green rounded-full animate-spin mx-auto" style="animation-direction: reverse; animation-duration: 1.5s;"></div>
        </div>
        
        {* Loading text *}
        <div class="mt-4 text-white font-medium" id="loading-text">Loading...</div>
        <div class="mt-2 text-gray-400 text-sm" id="loading-subtext"></div>
        
        {* Progress bar for longer operations *}
        <div class="mt-4 w-64 mx-auto hidden" id="loading-progress-container">
            <div class="w-full bg-gray-700 rounded-full h-2">
                <div class="bg-gradient-to-r from-ds-green to-ds-blue h-2 rounded-full transition-all duration-300 ease-out" 
                     id="loading-progress-bar" style="width: 0%"></div>
            </div>
            <div class="mt-2 text-xs text-gray-400" id="loading-progress-text">0%</div>
        </div>
    </div>
</div>

{* Inline loading components for specific sections *}
<template id="inline-loading-template">
    <div class="inline-loading flex items-center justify-center p-8" role="status" aria-label="Loading">
        <div class="text-center">
            <div class="w-8 h-8 border-2 border-gray-600 border-t-ds-blue rounded-full animate-spin mx-auto"></div>
            <div class="mt-2 text-sm text-gray-400">Loading...</div>
        </div>
    </div>
</template>

{* Button loading state template *}
<template id="button-loading-template">
    <div class="button-loading flex items-center space-x-2">
        <div class="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin"></div>
        <span>Loading...</span>
    </div>
</template>

{* Card loading skeleton template *}
<template id="card-loading-template">
    <div class="card-loading animate-pulse">
        <div class="bg-gray-800 border border-gray-700 rounded-lg p-6">
            <div class="flex items-start justify-between mb-4">
                <div class="flex-1">
                    <div class="h-6 bg-gray-700 rounded w-3/4 mb-2"></div>
                    <div class="h-4 bg-gray-700 rounded w-1/2"></div>
                </div>
                <div class="w-12 h-12 bg-gray-700 rounded"></div>
            </div>
            <div class="space-y-2 mb-4">
                <div class="h-4 bg-gray-700 rounded w-full"></div>
                <div class="h-4 bg-gray-700 rounded w-5/6"></div>
                <div class="h-4 bg-gray-700 rounded w-4/6"></div>
            </div>
            <div class="h-10 bg-gray-700 rounded w-full"></div>
        </div>
    </div>
</template>

{* Domain search loading template *}
<template id="domain-search-loading-template">
    <div class="domain-search-loading text-center py-8">
        <div class="inline-block relative">
            <div class="w-12 h-12 border-4 border-gray-600 border-t-ds-blue rounded-full animate-spin"></div>
            <div class="absolute inset-0 w-12 h-12 border-4 border-transparent border-r-ds-purple rounded-full animate-spin" style="animation-direction: reverse; animation-duration: 2s;"></div>
        </div>
        <div class="mt-4 text-white font-medium">Searching domains...</div>
        <div class="mt-2 text-gray-400 text-sm">This may take a few seconds</div>
    </div>
</template>

{* Form submission loading template *}
<template id="form-loading-template">
    <div class="form-loading fixed inset-0 bg-gray-950/50 flex items-center justify-center z-40">
        <div class="bg-gray-900 border border-gray-700 rounded-lg p-6 max-w-sm w-full mx-4">
            <div class="text-center">
                <div class="w-12 h-12 border-4 border-gray-600 border-t-ds-green rounded-full animate-spin mx-auto"></div>
                <div class="mt-4 text-white font-medium">Processing...</div>
                <div class="mt-2 text-gray-400 text-sm">Please wait while we process your request</div>
            </div>
        </div>
    </div>
</template>

<script>
    // Loading system functionality
    window.LoadingSystem = {
        // Show global loading overlay
        show: function(text = 'Loading...', subtext = '') {
            const overlay = document.getElementById('global-loading-overlay');
            const textElement = document.getElementById('loading-text');
            const subtextElement = document.getElementById('loading-subtext');
            
            if (overlay) {
                if (textElement) textElement.textContent = text;
                if (subtextElement) subtextElement.textContent = subtext;
                
                overlay.classList.remove('hidden');
                overlay.classList.add('flex');
                overlay.setAttribute('aria-hidden', 'false');
                
                // Prevent body scroll
                document.body.style.overflow = 'hidden';
            }
        },
        
        // Hide global loading overlay
        hide: function() {
            const overlay = document.getElementById('global-loading-overlay');
            if (overlay) {
                overlay.classList.add('hidden');
                overlay.classList.remove('flex');
                overlay.setAttribute('aria-hidden', 'true');
                
                // Restore body scroll
                document.body.style.overflow = '';
            }
        },
        
        // Show progress bar
        showProgress: function(progress = 0, text = '') {
            const container = document.getElementById('loading-progress-container');
            const bar = document.getElementById('loading-progress-bar');
            const progressText = document.getElementById('loading-progress-text');
            
            if (container) {
                container.classList.remove('hidden');
                
                if (bar) {
                    bar.style.width = Math.min(Math.max(progress, 0), 100) + '%';
                }
                
                if (progressText) {
                    progressText.textContent = text || Math.round(progress) + '%';
                }
            }
        },
        
        // Hide progress bar
        hideProgress: function() {
            const container = document.getElementById('loading-progress-container');
            if (container) {
                container.classList.add('hidden');
            }
        },
        
        // Show inline loading in a container
        showInline: function(container, text = 'Loading...') {
            if (typeof container === 'string') {
                container = document.getElementById(container);
            }
            
            if (container) {
                const template = document.getElementById('inline-loading-template');
                if (template) {
                    const clone = template.content.cloneNode(true);
                    const textElement = clone.querySelector('.inline-loading .text-sm');
                    if (textElement) textElement.textContent = text;
                    
                    container.innerHTML = '';
                    container.appendChild(clone);
                }
            }
        },
        
        // Show button loading state
        showButtonLoading: function(button, text = 'Loading...') {
            if (typeof button === 'string') {
                button = document.getElementById(button);
            }
            
            if (button) {
                // Store original content
                button.setAttribute('data-original-content', button.innerHTML);
                button.disabled = true;
                
                const template = document.getElementById('button-loading-template');
                if (template) {
                    const clone = template.content.cloneNode(true);
                    const textElement = clone.querySelector('span');
                    if (textElement) textElement.textContent = text;
                    
                    button.innerHTML = '';
                    button.appendChild(clone);
                }
            }
        },
        
        // Hide button loading state
        hideButtonLoading: function(button) {
            if (typeof button === 'string') {
                button = document.getElementById(button);
            }
            
            if (button) {
                const originalContent = button.getAttribute('data-original-content');
                if (originalContent) {
                    button.innerHTML = originalContent;
                    button.removeAttribute('data-original-content');
                }
                button.disabled = false;
            }
        },
        
        // Show card loading skeleton
        showCardLoading: function(container, count = 1) {
            if (typeof container === 'string') {
                container = document.getElementById(container);
            }
            
            if (container) {
                const template = document.getElementById('card-loading-template');
                if (template) {
                    container.innerHTML = '';
                    
                    for (let i = 0; i < count; i++) {
                        const clone = template.content.cloneNode(true);
                        container.appendChild(clone);
                    }
                }
            }
        },
        
        // Show domain search loading
        showDomainSearchLoading: function(container) {
            if (typeof container === 'string') {
                container = document.getElementById(container);
            }
            
            if (container) {
                const template = document.getElementById('domain-search-loading-template');
                if (template) {
                    const clone = template.content.cloneNode(true);
                    container.innerHTML = '';
                    container.appendChild(clone);
                }
            }
        },
        
        // Show form loading overlay
        showFormLoading: function(text = 'Processing...', subtext = 'Please wait while we process your request') {
            const template = document.getElementById('form-loading-template');
            if (template) {
                const clone = template.content.cloneNode(true);
                const textElement = clone.querySelector('.text-white');
                const subtextElement = clone.querySelector('.text-gray-400');
                
                if (textElement) textElement.textContent = text;
                if (subtextElement) subtextElement.textContent = subtext;
                
                document.body.appendChild(clone);
            }
        },
        
        // Hide form loading overlay
        hideFormLoading: function() {
            const formLoading = document.querySelector('.form-loading');
            if (formLoading) {
                formLoading.remove();
            }
        }
    };
    
    // Make LoadingSystem globally available
    window.OrderForm = window.OrderForm || {};
    window.OrderForm.showLoading = window.LoadingSystem.show;
    window.OrderForm.hideLoading = window.LoadingSystem.hide;
    window.OrderForm.showProgress = window.LoadingSystem.showProgress;
    window.OrderForm.showInlineLoading = window.LoadingSystem.showInline;
    window.OrderForm.showButtonLoading = window.LoadingSystem.showButtonLoading;
    window.OrderForm.hideButtonLoading = window.LoadingSystem.hideButtonLoading;
    window.OrderForm.showCardLoading = window.LoadingSystem.showCardLoading;
    window.OrderForm.showDomainSearchLoading = window.LoadingSystem.showDomainSearchLoading;
    window.OrderForm.showFormLoading = window.LoadingSystem.showFormLoading;
    window.OrderForm.hideFormLoading = window.LoadingSystem.hideFormLoading;
    
    // Auto-hide loading on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Hide any existing loading states after a brief delay
        setTimeout(() => {
            window.LoadingSystem.hide();
        }, 100);
    });
</script>