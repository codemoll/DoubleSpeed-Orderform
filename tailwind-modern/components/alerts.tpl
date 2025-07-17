{*
 * Alerts Component
 * Comprehensive alert system for user feedback
 * Supports success, error, warning, and info messages
 *
 * Variables:
 * $alerts - Array of alert objects with type, message, title (optional)
 * $alert - Single alert object for individual display
 *}

{* Global alert container - populated by JavaScript *}
<div id="global-alerts" class="space-y-4">
    {* Server-side alerts from WHMCS *}
    {if $errormessage}
        <div class="alert alert-error animate-slide-up" role="alert" aria-live="assertive">
            <div class="flex items-start space-x-3 p-4 border border-red-500/20 bg-red-500/10 rounded-lg">
                <div class="flex-shrink-0">
                    <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
                <div class="flex-1">
                    <h3 class="text-sm font-medium text-red-300">Error</h3>
                    <div class="mt-1 text-sm text-red-200">{$errormessage}</div>
                </div>
                <button type="button" class="flex-shrink-0 text-red-400 hover:text-red-300 transition-colors duration-200" onclick="this.closest('.alert').remove()" aria-label="Dismiss error">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
        </div>
    {/if}
    
    {if $successmessage}
        <div class="alert alert-success animate-slide-up" role="alert" aria-live="polite">
            <div class="flex items-start space-x-3 p-4 border border-green-500/20 bg-green-500/10 rounded-lg">
                <div class="flex-shrink-0">
                    <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
                <div class="flex-1">
                    <h3 class="text-sm font-medium text-green-300">Success</h3>
                    <div class="mt-1 text-sm text-green-200">{$successmessage}</div>
                </div>
                <button type="button" class="flex-shrink-0 text-green-400 hover:text-green-300 transition-colors duration-200" onclick="this.closest('.alert').remove()" aria-label="Dismiss success message">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
        </div>
    {/if}
    
    {if $infomessage}
        <div class="alert alert-info animate-slide-up" role="alert" aria-live="polite">
            <div class="flex items-start space-x-3 p-4 border border-blue-500/20 bg-blue-500/10 rounded-lg">
                <div class="flex-shrink-0">
                    <svg class="w-5 h-5 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
                <div class="flex-1">
                    <h3 class="text-sm font-medium text-blue-300">Information</h3>
                    <div class="mt-1 text-sm text-blue-200">{$infomessage}</div>
                </div>
                <button type="button" class="flex-shrink-0 text-blue-400 hover:text-blue-300 transition-colors duration-200" onclick="this.closest('.alert').remove()" aria-label="Dismiss information">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
        </div>
    {/if}
    
    {* Custom alerts array *}
    {if $alerts}
        {foreach from=$alerts item=alert}
            <div class="alert alert-{$alert.type|default:'info'} animate-slide-up" role="alert" aria-live="{if $alert.type == 'error'}assertive{else}polite{/if}">
                <div class="flex items-start space-x-3 p-4 border rounded-lg
                    {if $alert.type == 'error'}
                        border-red-500/20 bg-red-500/10
                    {elseif $alert.type == 'success'}
                        border-green-500/20 bg-green-500/10
                    {elseif $alert.type == 'warning'}
                        border-yellow-500/20 bg-yellow-500/10
                    {else}
                        border-blue-500/20 bg-blue-500/10
                    {/if}">
                    
                    <div class="flex-shrink-0">
                        {if $alert.type == 'error'}
                            <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        {elseif $alert.type == 'success'}
                            <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        {elseif $alert.type == 'warning'}
                            <svg class="w-5 h-5 text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.268 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                            </svg>
                        {else}
                            <svg class="w-5 h-5 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        {/if}
                    </div>
                    
                    <div class="flex-1">
                        {if $alert.title}
                            <h3 class="text-sm font-medium
                                {if $alert.type == 'error'}text-red-300
                                {elseif $alert.type == 'success'}text-green-300
                                {elseif $alert.type == 'warning'}text-yellow-300
                                {else}text-blue-300{/if}">
                                {$alert.title}
                            </h3>
                        {/if}
                        <div class="mt-1 text-sm
                            {if $alert.type == 'error'}text-red-200
                            {elseif $alert.type == 'success'}text-green-200
                            {elseif $alert.type == 'warning'}text-yellow-200
                            {else}text-blue-200{/if}">
                            {$alert.message}
                        </div>
                    </div>
                    
                    <button type="button" 
                            class="flex-shrink-0 transition-colors duration-200
                                {if $alert.type == 'error'}text-red-400 hover:text-red-300
                                {elseif $alert.type == 'success'}text-green-400 hover:text-green-300
                                {elseif $alert.type == 'warning'}text-yellow-400 hover:text-yellow-300
                                {else}text-blue-400 hover:text-blue-300{/if}"
                            onclick="this.closest('.alert').remove()" 
                            aria-label="Dismiss alert">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
            </div>
        {/foreach}
    {/if}
</div>

{* Toast notification container for JavaScript-generated alerts *}
<div id="toast-container" 
     class="fixed top-4 right-4 z-50 space-y-2 pointer-events-none" 
     aria-live="polite" 
     aria-atomic="true">
    {* Toast notifications will be dynamically inserted here *}
</div>

<style>
    /* Custom animations for alerts */
    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes slideOut {
        from {
            opacity: 1;
            transform: translateX(0);
            max-height: 200px;
            margin-bottom: 1rem;
        }
        to {
            opacity: 0;
            transform: translateX(100%);
            max-height: 0;
            margin-bottom: 0;
        }
    }
    
    .alert-slide-out {
        animation: slideOut 0.3s ease-in-out forwards;
    }
    
    .toast-enter {
        animation: slideUp 0.3s ease-out;
    }
    
    .toast-exit {
        animation: slideOut 0.3s ease-in-out forwards;
    }
</style>

<script>
    // Alert system JavaScript functionality
    window.AlertSystem = {
        // Show a dynamic alert
        show: function(message, type = 'info', title = null, duration = 5000) {
            const container = document.getElementById('global-alerts');
            if (!container) return;
            
            const alertId = 'alert-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
            const typeColors = {
                error: { border: 'border-red-500/20', bg: 'bg-red-500/10', text: 'text-red-400', titleText: 'text-red-300', bodyText: 'text-red-200' },
                success: { border: 'border-green-500/20', bg: 'bg-green-500/10', text: 'text-green-400', titleText: 'text-green-300', bodyText: 'text-green-200' },
                warning: { border: 'border-yellow-500/20', bg: 'bg-yellow-500/10', text: 'text-yellow-400', titleText: 'text-yellow-300', bodyText: 'text-yellow-200' },
                info: { border: 'border-blue-500/20', bg: 'bg-blue-500/10', text: 'text-blue-400', titleText: 'text-blue-300', bodyText: 'text-blue-200' }
            };
            
            const colors = typeColors[type] || typeColors.info;
            
            const icons = {
                error: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>',
                success: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>',
                warning: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.268 16.5c-.77.833.192 2.5 1.732 2.5z"></path>',
                info: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>'
            };
            
            const alertHtml = `
                <div id="${alertId}" class="alert alert-${type} animate-slide-up" role="alert" aria-live="${type === 'error' ? 'assertive' : 'polite'}">
                    <div class="flex items-start space-x-3 p-4 border ${colors.border} ${colors.bg} rounded-lg">
                        <div class="flex-shrink-0">
                            <svg class="w-5 h-5 ${colors.text}" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                ${icons[type] || icons.info}
                            </svg>
                        </div>
                        <div class="flex-1">
                            ${title ? `<h3 class="text-sm font-medium ${colors.titleText}">${title}</h3>` : ''}
                            <div class="mt-1 text-sm ${colors.bodyText}">${message}</div>
                        </div>
                        <button type="button" class="flex-shrink-0 ${colors.text} hover:opacity-75 transition-opacity duration-200" onclick="AlertSystem.dismiss('${alertId}')" aria-label="Dismiss alert">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            `;
            
            container.insertAdjacentHTML('beforeend', alertHtml);
            
            // Auto-dismiss after duration
            if (duration > 0) {
                setTimeout(() => {
                    this.dismiss(alertId);
                }, duration);
            }
            
            return alertId;
        },
        
        // Show a toast notification
        showToast: function(message, type = 'info', duration = 4000) {
            const container = document.getElementById('toast-container');
            if (!container) return;
            
            const toastId = 'toast-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
            const typeColors = {
                error: 'bg-red-600 border-red-500',
                success: 'bg-green-600 border-green-500',
                warning: 'bg-yellow-600 border-yellow-500',
                info: 'bg-blue-600 border-blue-500'
            };
            
            const colors = typeColors[type] || typeColors.info;
            
            const toastHtml = `
                <div id="${toastId}" class="toast-enter pointer-events-auto max-w-sm w-full ${colors} border rounded-lg shadow-lg p-4">
                    <div class="flex items-start">
                        <div class="flex-1 text-sm text-white font-medium">
                            ${message}
                        </div>
                        <button type="button" class="ml-3 text-white hover:opacity-75 transition-opacity duration-200" onclick="AlertSystem.dismissToast('${toastId}')" aria-label="Dismiss notification">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            `;
            
            container.insertAdjacentHTML('beforeend', toastHtml);
            
            // Auto-dismiss after duration
            if (duration > 0) {
                setTimeout(() => {
                    this.dismissToast(toastId);
                }, duration);
            }
            
            return toastId;
        },
        
        // Dismiss an alert
        dismiss: function(alertId) {
            const alert = document.getElementById(alertId);
            if (alert) {
                alert.classList.add('alert-slide-out');
                setTimeout(() => {
                    alert.remove();
                }, 300);
            }
        },
        
        // Dismiss a toast notification
        dismissToast: function(toastId) {
            const toast = document.getElementById(toastId);
            if (toast) {
                toast.classList.add('toast-exit');
                setTimeout(() => {
                    toast.remove();
                }, 300);
            }
        },
        
        // Clear all alerts
        clearAll: function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.classList.add('alert-slide-out');
                setTimeout(() => {
                    alert.remove();
                }, 300);
            });
        }
    };
    
    // Make AlertSystem globally available
    window.OrderForm = window.OrderForm || {};
    window.OrderForm.showAlert = window.AlertSystem.show;
    window.OrderForm.showToast = window.AlertSystem.showToast;
    window.OrderForm.dismissAlert = window.AlertSystem.dismiss;
    window.OrderForm.clearAlerts = window.AlertSystem.clearAll;
</script>