/**
 * Tailwind Modern Order Form - Main JavaScript
 * Comprehensive order form functionality with enhanced UX
 */

// Global OrderForm namespace
window.OrderForm = window.OrderForm || {};

// Configuration
OrderForm.config = {
    apiEndpoint: '/cart.php',
    domainSearchEndpoint: '/includes/domainsearch.php',
    validatePromoEndpoint: '/includes/validatepromo.php',
    defaultCurrency: { prefix: '$', suffix: '' },
    autoSaveInterval: 30000, // 30 seconds
    domainSearchDelay: 1000, // 1 second delay for domain search
    maxRetries: 3
};

// State management
OrderForm.state = {
    cart: {
        products: [],
        domains: [],
        addons: [],
        promotions: [],
        subtotal: 0,
        total: 0,
        currency: OrderForm.config.defaultCurrency
    },
    currentStep: 1,
    isLoading: false,
    retryCount: 0
};

// Utility functions
OrderForm.utils = {
    // Format currency
    formatCurrency: function(amount, currency = null) {
        currency = currency || OrderForm.state.cart.currency;
        const formatted = parseFloat(amount).toFixed(2);
        return `${currency.prefix}${formatted}${currency.suffix}`;
    },
    
    // Debounce function
    debounce: function(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    },
    
    // Generate unique ID
    generateId: function() {
        return Date.now().toString(36) + Math.random().toString(36).substr(2);
    },
    
    // Validate email
    validateEmail: function(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    },
    
    // Validate domain name
    validateDomain: function(domain) {
        const re = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$/;
        return re.test(domain);
    },
    
    // Sanitize input
    sanitizeInput: function(input) {
        const div = document.createElement('div');
        div.textContent = input;
        return div.innerHTML;
    },
    
    // Get CSRF token
    getCSRFToken: function() {
        const tokenElement = document.querySelector('meta[name="csrf-token"]') || 
                            document.querySelector('input[name="token"]');
        return tokenElement ? tokenElement.content || tokenElement.value : '';
    }
};

// API functions
OrderForm.api = {
    // Generic API request
    request: async function(url, options = {}) {
        const defaultOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': OrderForm.utils.getCSRFToken()
            },
            credentials: 'same-origin'
        };
        
        const finalOptions = { ...defaultOptions, ...options };
        
        try {
            const response = await fetch(url, finalOptions);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const contentType = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                return await response.json();
            } else {
                return await response.text();
            }
        } catch (error) {
            console.error('API request failed:', error);
            throw error;
        }
    },
    
    // Add product to cart
    addProduct: async function(productId, options = {}) {
        OrderForm.showLoading('Adding product to cart...');
        
        try {
            const data = {
                a: 'add',
                pid: productId,
                ...options
            };
            
            const response = await this.request(OrderForm.config.apiEndpoint, {
                body: JSON.stringify(data)
            });
            
            if (response.success) {
                await OrderForm.cart.refresh();
                OrderForm.showAlert('Product added to cart successfully!', 'success');
                return response;
            } else {
                throw new Error(response.message || 'Failed to add product');
            }
        } catch (error) {
            OrderForm.showAlert('Failed to add product to cart. Please try again.', 'error');
            throw error;
        } finally {
            OrderForm.hideLoading();
        }
    },
    
    // Search domains
    searchDomains: async function(query, tlds = []) {
        const searchData = {
            domain: query,
            tlds: tlds.length ? tlds : ['com', 'net', 'org', 'info']
        };
        
        try {
            const response = await this.request(OrderForm.config.domainSearchEndpoint, {
                body: JSON.stringify(searchData)
            });
            
            if (response.results) {
                return response.results;
            } else {
                throw new Error('Invalid domain search response');
            }
        } catch (error) {
            console.error('Domain search failed:', error);
            throw error;
        }
    },
    
    // Validate promotion code
    validatePromotion: async function(code) {
        try {
            const response = await this.request(OrderForm.config.validatePromoEndpoint, {
                body: JSON.stringify({ code: code })
            });
            
            return response;
        } catch (error) {
            console.error('Promotion validation failed:', error);
            throw error;
        }
    }
};

// Cart management
OrderForm.cart = {
    // Add product
    addProduct: function(product) {
        const existingIndex = OrderForm.state.cart.products.findIndex(p => p.id === product.id);
        
        if (existingIndex >= 0) {
            OrderForm.state.cart.products[existingIndex] = product;
        } else {
            OrderForm.state.cart.products.push(product);
        }
        
        this.updateTotals();
        this.updateDisplay();
        this.save();
    },
    
    // Remove product
    removeProduct: function(productId) {
        OrderForm.state.cart.products = OrderForm.state.cart.products.filter(p => p.id !== productId);
        this.updateTotals();
        this.updateDisplay();
        this.save();
        
        // Dispatch cart updated event
        document.dispatchEvent(new CustomEvent('cartUpdated'));
    },
    
    // Add domain
    addDomain: function(domain) {
        const existingIndex = OrderForm.state.cart.domains.findIndex(d => d.name === domain.name);
        
        if (existingIndex >= 0) {
            OrderForm.state.cart.domains[existingIndex] = domain;
        } else {
            OrderForm.state.cart.domains.push(domain);
        }
        
        this.updateTotals();
        this.updateDisplay();
        this.save();
    },
    
    // Remove domain
    removeDomain: function(domainId) {
        OrderForm.state.cart.domains = OrderForm.state.cart.domains.filter(d => d.id !== domainId);
        this.updateTotals();
        this.updateDisplay();
        this.save();
        
        // Dispatch cart updated event
        document.dispatchEvent(new CustomEvent('cartUpdated'));
    },
    
    // Apply promotion
    applyPromotion: function(promotion) {
        const existingIndex = OrderForm.state.cart.promotions.findIndex(p => p.code === promotion.code);
        
        if (existingIndex >= 0) {
            OrderForm.state.cart.promotions[existingIndex] = promotion;
        } else {
            OrderForm.state.cart.promotions.push(promotion);
        }
        
        this.updateTotals();
        this.updateDisplay();
        this.save();
    },
    
    // Remove promotion
    removePromotion: function(code) {
        OrderForm.state.cart.promotions = OrderForm.state.cart.promotions.filter(p => p.code !== code);
        this.updateTotals();
        this.updateDisplay();
        this.save();
    },
    
    // Update totals
    updateTotals: function() {
        let subtotal = 0;
        
        // Add product prices
        OrderForm.state.cart.products.forEach(product => {
            subtotal += parseFloat(product.price || 0);
        });
        
        // Add domain prices
        OrderForm.state.cart.domains.forEach(domain => {
            subtotal += parseFloat(domain.price || 0);
        });
        
        // Add addon prices
        OrderForm.state.cart.addons.forEach(addon => {
            subtotal += parseFloat(addon.price || 0);
        });
        
        OrderForm.state.cart.subtotal = subtotal;
        
        // Apply promotions
        let discount = 0;
        OrderForm.state.cart.promotions.forEach(promo => {
            discount += parseFloat(promo.discount || 0);
        });
        
        OrderForm.state.cart.total = Math.max(0, subtotal - discount);
    },
    
    // Update display
    updateDisplay: function() {
        // Update sidebar
        this.updateSidebar();
        
        // Update header cart count
        this.updateCartCount();
        
        // Update any step-specific displays
        if (typeof window.updateStepDisplay === 'function') {
            window.updateStepDisplay();
        }
    },
    
    // Update sidebar
    updateSidebar: function() {
        const sidebar = document.getElementById('order-summary-content');
        if (!sidebar) return;
        
        // Show/hide sections based on cart contents
        const productsSection = document.getElementById('products-section');
        const domainsSection = document.getElementById('domains-section');
        const emptyMessage = document.getElementById('empty-cart-message');
        
        const hasItems = OrderForm.state.cart.products.length > 0 || OrderForm.state.cart.domains.length > 0;
        
        if (productsSection) {
            productsSection.classList.toggle('hidden', OrderForm.state.cart.products.length === 0);
        }
        
        if (domainsSection) {
            domainsSection.classList.toggle('hidden', OrderForm.state.cart.domains.length === 0);
        }
        
        if (emptyMessage) {
            emptyMessage.classList.toggle('hidden', hasItems);
        }
        
        // Update totals
        const subtotalElement = document.getElementById('subtotal-amount');
        const totalElement = document.getElementById('total-amount');
        const mobileTotalElement = document.getElementById('mobile-total');
        
        if (subtotalElement) {
            subtotalElement.textContent = OrderForm.utils.formatCurrency(OrderForm.state.cart.subtotal);
        }
        
        if (totalElement) {
            totalElement.textContent = OrderForm.utils.formatCurrency(OrderForm.state.cart.total);
        }
        
        if (mobileTotalElement) {
            mobileTotalElement.textContent = OrderForm.utils.formatCurrency(OrderForm.state.cart.total);
        }
    },
    
    // Update cart count
    updateCartCount: function() {
        const cartCount = document.getElementById('cart-count');
        if (cartCount) {
            const count = OrderForm.state.cart.products.length + OrderForm.state.cart.domains.length;
            cartCount.textContent = count;
            cartCount.style.display = count > 0 ? 'flex' : 'none';
        }
    },
    
    // Clear cart
    clear: function() {
        OrderForm.state.cart.products = [];
        OrderForm.state.cart.domains = [];
        OrderForm.state.cart.addons = [];
        OrderForm.state.cart.promotions = [];
        this.updateTotals();
        this.updateDisplay();
        this.save();
        
        OrderForm.showAlert('Cart cleared successfully', 'info');
    },
    
    // Save cart to localStorage
    save: function() {
        try {
            localStorage.setItem('orderform_cart', JSON.stringify(OrderForm.state.cart));
        } catch (error) {
            console.warn('Failed to save cart to localStorage:', error);
        }
    },
    
    // Load cart from localStorage
    load: function() {
        try {
            const saved = localStorage.getItem('orderform_cart');
            if (saved) {
                const cartData = JSON.parse(saved);
                OrderForm.state.cart = { ...OrderForm.state.cart, ...cartData };
                this.updateDisplay();
            }
        } catch (error) {
            console.warn('Failed to load cart from localStorage:', error);
        }
    },
    
    // Refresh cart from server
    refresh: async function() {
        try {
            const response = await OrderForm.api.request(OrderForm.config.apiEndpoint + '?a=view');
            if (response.cart) {
                OrderForm.state.cart = { ...OrderForm.state.cart, ...response.cart };
                this.updateDisplay();
            }
        } catch (error) {
            console.warn('Failed to refresh cart from server:', error);
        }
    }
};

// Domain search functionality
OrderForm.domains = {
    searchTimeout: null,
    
    // Search domains with debouncing
    search: function(query, container, tlds = []) {
        // Clear previous timeout
        if (this.searchTimeout) {
            clearTimeout(this.searchTimeout);
        }
        
        // Validate input
        if (!query || query.length < 2) {
            return;
        }
        
        // Debounce search
        this.searchTimeout = setTimeout(async () => {
            await this.performSearch(query, container, tlds);
        }, OrderForm.config.domainSearchDelay);
    },
    
    // Perform actual domain search
    performSearch: async function(query, container, tlds = []) {
        const searchContainer = typeof container === 'string' ? 
            document.getElementById(container) : container;
            
        if (!searchContainer) {
            console.error('Search container not found');
            return;
        }
        
        // Show loading state
        OrderForm.showDomainSearchLoading(searchContainer);
        
        try {
            const results = await OrderForm.api.searchDomains(query, tlds);
            this.displayResults(results, searchContainer);
        } catch (error) {
            this.displayError(searchContainer, 'Domain search failed. Please try again.');
            OrderForm.showAlert('Domain search failed. Please check your connection and try again.', 'error');
        }
    },
    
    // Display search results
    displayResults: function(results, container) {
        if (!Array.isArray(results) || results.length === 0) {
            this.displayError(container, 'No domain results found. Please try a different search term.');
            return;
        }
        
        let html = '<div class="space-y-3">';
        
        results.forEach(result => {
            const statusColor = result.available ? 'ds-green' : 'red-500';
            const statusText = result.available ? 'Available' : 'Unavailable';
            const actionButton = result.available ? 
                `<button type="button" 
                        onclick="OrderForm.domains.select('${result.name}', '${result.price}')" 
                        class="bg-ds-blue hover:bg-blue-600 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200">
                    Add $${result.price}/year
                </button>` :
                `<span class="text-red-400 text-sm">Unavailable</span>`;
            
            html += `
                <div class="flex items-center justify-between p-4 border border-gray-600 rounded-lg ${result.available ? 'bg-gray-800 hover:border-gray-500' : 'bg-gray-800/50'} transition-colors duration-200">
                    <div class="flex items-center space-x-3">
                        <div class="w-3 h-3 rounded-full bg-${statusColor}"></div>
                        <div>
                            <div class="font-medium text-white">${OrderForm.utils.sanitizeInput(result.name)}</div>
                            <div class="text-sm text-gray-400">${statusText}</div>
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <span class="text-ds-green font-semibold">$${result.price}/year</span>
                        ${actionButton}
                    </div>
                </div>
            `;
        });
        
        html += '</div>';
        container.innerHTML = html;
    },
    
    // Display error message
    displayError: function(container, message) {
        container.innerHTML = `
            <div class="text-center py-8">
                <div class="w-16 h-16 bg-red-500/10 border border-red-500/20 rounded-full flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-medium text-white mb-2">Search Error</h3>
                <p class="text-gray-400">${OrderForm.utils.sanitizeInput(message)}</p>
                <button type="button" 
                        onclick="this.closest('.space-y-3, div').innerHTML = ''" 
                        class="mt-4 text-ds-blue hover:text-blue-400 text-sm underline">
                    Try Again
                </button>
            </div>
        `;
    },
    
    // Select domain
    select: function(domainName, price) {
        const domain = {
            id: OrderForm.utils.generateId(),
            name: domainName,
            price: parseFloat(price),
            type: 'registration',
            years: 1
        };
        
        OrderForm.cart.addDomain(domain);
        OrderForm.showToast(`Domain ${domainName} added to cart!`, 'success');
    }
};

// Form validation
OrderForm.validation = {
    // Validate form
    validateForm: function(form) {
        const errors = [];
        const requiredFields = form.querySelectorAll('[required]');
        
        requiredFields.forEach(field => {
            if (!this.validateField(field)) {
                errors.push(this.getFieldError(field));
            }
        });
        
        return {
            isValid: errors.length === 0,
            errors: errors
        };
    },
    
    // Validate individual field
    validateField: function(field) {
        const value = field.value.trim();
        
        // Check if required field is empty
        if (field.hasAttribute('required') && !value) {
            this.showFieldError(field, 'This field is required');
            return false;
        }
        
        // Validate based on field type
        switch (field.type) {
            case 'email':
                if (value && !OrderForm.utils.validateEmail(value)) {
                    this.showFieldError(field, 'Please enter a valid email address');
                    return false;
                }
                break;
                
            case 'password':
                if (value && value.length < 8) {
                    this.showFieldError(field, 'Password must be at least 8 characters long');
                    return false;
                }
                break;
                
            case 'tel':
                if (value && !/^[\d\s\-\+\(\)]+$/.test(value)) {
                    this.showFieldError(field, 'Please enter a valid phone number');
                    return false;
                }
                break;
        }
        
        // Validate based on pattern attribute
        if (field.pattern && value && !new RegExp(field.pattern).test(value)) {
            this.showFieldError(field, field.title || 'Please enter a valid value');
            return false;
        }
        
        // Clear any existing errors
        this.clearFieldError(field);
        return true;
    },
    
    // Show field error
    showFieldError: function(field, message) {
        field.classList.add('border-red-500');
        field.classList.remove('border-gray-600');
        
        // Remove existing error message
        this.clearFieldError(field, false);
        
        // Add new error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'field-error text-red-400 text-sm mt-1';
        errorDiv.textContent = message;
        field.parentNode.appendChild(errorDiv);
        
        // Set ARIA attributes
        field.setAttribute('aria-invalid', 'true');
        const errorId = 'error-' + (field.id || OrderForm.utils.generateId());
        errorDiv.id = errorId;
        field.setAttribute('aria-describedby', errorId);
    },
    
    // Clear field error
    clearFieldError: function(field, resetBorder = true) {
        if (resetBorder) {
            field.classList.remove('border-red-500');
            field.classList.add('border-gray-600');
        }
        
        // Remove error message
        const errorDiv = field.parentNode.querySelector('.field-error');
        if (errorDiv) {
            errorDiv.remove();
        }
        
        // Clear ARIA attributes
        field.removeAttribute('aria-invalid');
        field.removeAttribute('aria-describedby');
    },
    
    // Get field error message
    getFieldError: function(field) {
        const errorDiv = field.parentNode.querySelector('.field-error');
        return errorDiv ? errorDiv.textContent : 'Invalid field';
    }
};

// Promotion code handling
OrderForm.promotions = {
    // Apply promotion code
    apply: async function(event) {
        event.preventDefault();
        
        const form = event.target;
        const codeInput = form.querySelector('#promo-code');
        const submitBtn = form.querySelector('#apply-promo-btn');
        const feedback = form.querySelector('#promo-feedback');
        
        if (!codeInput || !submitBtn) return false;
        
        const code = codeInput.value.trim();
        
        if (!code) {
            this.showFeedback(feedback, 'Please enter a promotion code', 'error');
            return false;
        }
        
        // Show loading state
        OrderForm.showButtonLoading(submitBtn, 'Applying...');
        
        try {
            const response = await OrderForm.api.validatePromotion(code);
            
            if (response.valid) {
                const promotion = {
                    code: code,
                    description: response.description || 'Promotion applied',
                    discount: response.discount || 0
                };
                
                OrderForm.cart.applyPromotion(promotion);
                this.showFeedback(feedback, 'Promotion code applied successfully!', 'success');
                
                // Clear form
                codeInput.value = '';
                
                // Hide form after successful application
                setTimeout(() => {
                    form.style.display = 'none';
                }, 2000);
                
            } else {
                this.showFeedback(feedback, response.message || 'Invalid promotion code', 'error');
            }
        } catch (error) {
            this.showFeedback(feedback, 'Failed to validate promotion code. Please try again.', 'error');
        } finally {
            OrderForm.hideButtonLoading(submitBtn);
        }
        
        return false;
    },
    
    // Show feedback message
    showFeedback: function(element, message, type) {
        if (!element) return;
        
        const colorClasses = {
            success: 'text-green-400',
            error: 'text-red-400',
            info: 'text-blue-400'
        };
        
        element.textContent = message;
        element.className = `text-xs ${colorClasses[type] || colorClasses.info}`;
        
        // Clear after 5 seconds
        setTimeout(() => {
            element.textContent = '';
        }, 5000);
    }
};

// Initialize OrderForm
OrderForm.init = function() {
    console.log('OrderForm initializing...');
    
    // Load cart from localStorage
    this.cart.load();
    
    // Set up auto-save
    setInterval(() => {
        this.cart.save();
    }, this.config.autoSaveInterval);
    
    // Set up form validation
    document.addEventListener('blur', (e) => {
        if (e.target.matches('input, select, textarea')) {
            this.validation.validateField(e.target);
        }
    }, true);
    
    // Set up promotion form
    const promoForm = document.getElementById('promo-form');
    if (promoForm) {
        promoForm.addEventListener('submit', this.promotions.apply.bind(this.promotions));
    }
    
    // Set up global error handling
    window.addEventListener('unhandledrejection', (e) => {
        console.error('Unhandled promise rejection:', e.reason);
        this.showAlert('An unexpected error occurred. Please refresh the page and try again.', 'error');
    });
    
    console.log('OrderForm initialized successfully');
};

// Global functions for template compatibility
window.OrderForm.addProduct = OrderForm.api.addProduct;
window.OrderForm.removeProduct = OrderForm.cart.removeProduct.bind(OrderForm.cart);
window.OrderForm.removeDomain = OrderForm.cart.removeDomain.bind(OrderForm.cart);
window.OrderForm.removePromotion = OrderForm.cart.removePromotion.bind(OrderForm.cart);
window.OrderForm.clearCart = OrderForm.cart.clear.bind(OrderForm.cart);
window.OrderForm.saveCart = OrderForm.cart.save.bind(OrderForm.cart);
window.OrderForm.applyPromotion = OrderForm.promotions.apply.bind(OrderForm.promotions);
window.OrderForm.searchDomains = OrderForm.domains.search.bind(OrderForm.domains);
window.OrderForm.selectDomain = OrderForm.domains.select.bind(OrderForm.domains);

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', OrderForm.init.bind(OrderForm));