# Lagom2 Multi-Step Order Form for DoubleSpeedHost

A modern, responsive multi-step wizard order form template designed for WHMCS with DoubleSpeedHost branding and cyber-themed styling using Tailwind CSS.

## 📁 File Structure

```
lagom2steps/
├── step1-products.tpl      # Product selection page
├── step2-configure.tpl     # Product configuration page  
├── step3-domain.tpl        # Domain selection page
├── step4-summary.tpl       # Order review and summary page
├── step5-checkout.tpl      # Final checkout and payment page
├── order-progress.tpl      # Progress indicator partial
├── sidebar-summary.tpl     # Sticky order summary partial
└── README.md              # This documentation file
```

## 🎨 Design Features

### Color Scheme (DoubleSpeedHost Theme)
- **Neon Green** (`#00ff88`) - Primary accent, success states, pricing
- **Electric Blue** (`#0066ff`) - Secondary accent, links, active states  
- **Cyber Purple** (`#8800ff`) - Tertiary accent, special elements
- **Dark Gray Palette** - Background and card elements for cyber aesthetic

### Visual Elements
- Card-based layouts with subtle borders and hover effects
- Gradient buttons with hover animations
- Animated progress indicators
- Responsive grid system
- Icon integration with SVG icons
- Smooth transitions and micro-interactions

## 🔧 Technical Implementation

### Framework & Dependencies
- **Tailwind CSS** (CDN) - Utility-first CSS framework
- **Smarty Template Engine** - WHMCS templating system
- **Responsive Design** - Mobile-first approach
- **Vanilla JavaScript** - No external JS dependencies

### WHMCS Integration Points

#### Step 1 - Products (`step1-products.tpl`)
**Required WHMCS Variables:**
- `$productgroups` - Available product categories
- `$products` - Products in selected group
- `$currencies` - Available currencies
- `$selectedCurrency` - Current currency

**Form Actions:**
- `cart.php?a=add` - Add product to cart
- `cart.php?a=confproduct&i=0` - Continue to configuration

#### Step 2 - Configure (`step2-configure.tpl`)
**Required WHMCS Variables:**
- `$productinfo` - Selected product details
- `$billingcycles` - Available billing cycles
- `$addons` - Product add-ons
- `$customfields` - Custom product fields
- `$configoptions` - Configurable options

**Form Actions:**
- `cart.php` with `a=confdomains` - Continue to domain selection

#### Step 3 - Domain (`step3-domain.tpl`)
**Required WHMCS Variables:**
- `$domainpricing` - Domain pricing for registration
- `$transfertlds` - Available TLDs for transfer
- `$registertlds` - Available TLDs for registration
- `$incartdomains` - Domains already in cart

**Form Actions:**
- `cart.php` with `a=checkout` - Continue to summary

#### Step 4 - Summary (`step4-summary.tpl`)
**Required WHMCS Variables:**
- `$products` - Cart products
- `$domains` - Cart domains
- `$subtotal` - Order subtotal
- `$total` - Order total
- `$promotions` - Applied promotions
- `$tax` - Tax calculations

#### Step 5 - Checkout (`step5-checkout.tpl`)
**Required WHMCS Variables:**
- `$paymentmethods` - Available payment gateways
- `$clientdetails` - Customer information
- `$invoiceid` - Generated invoice ID
- `$loggedin` - Customer login status

## 🚀 Installation & Setup

### 1. File Placement
Copy all template files to your WHMCS order form template directory:
```
/path/to/whmcs/templates/orderforms/lagom2steps/
```

### 2. WHMCS Configuration
Update your WHMCS configuration to use the new order form:
- Navigate to **Setup → General Settings → Ordering**
- Set **Order Form Template** to `lagom2steps`

### 3. Template Customization
Update the template files with your specific:
- Company branding and logos
- Color scheme adjustments
- Additional form fields
- Custom product features
- Payment gateway configurations

### 4. CSS Customization
The templates use Tailwind CSS via CDN. For production use, consider:
- Creating a custom Tailwind build
- Adding your brand colors to the Tailwind config
- Optimizing for unused CSS classes

## 🔄 Workflow Integration

### Step Flow
1. **Products** → Select hosting products and view pricing
2. **Configure** → Customize product options and add-ons
3. **Domain** → Choose domain registration, transfer, or existing
4. **Summary** → Review order details and apply promotions
5. **Checkout** → Complete payment and account information

### Data Persistence
- Form data persists through browser sessions
- WHMCS cart system maintains order state
- JavaScript localStorage for UX enhancements

## 🎯 Customization Guide

### Adding New Steps
To add additional steps to the wizard:

1. **Create new template file**:
   ```smarty
   {assign var="currentStep" value=6}
   {include file="order-progress.tpl" currentStep=$currentStep}
   ```

2. **Update progress indicator**:
   Modify `order-progress.tpl` to include new step in `$stepTitles` array

3. **Update navigation**:
   Add navigation buttons linking to previous/next steps

### Modifying Colors
Update the Tailwind config in each template file:
```javascript
tailwind.config = {
    theme: {
        extend: {
            colors: {
                'ds-green': '#YOUR_GREEN',
                'ds-blue': '#YOUR_BLUE', 
                'ds-purple': '#YOUR_PURPLE'
            }
        }
    }
}
```

### Custom Fields Integration
Add custom fields to any step by including them in the form:
```smarty
{if $customfields}
    {foreach from=$customfields item=field}
        <!-- Custom field HTML -->
    {/foreach}
{/if}
```

### Payment Gateway Integration
Add new payment methods in `step5-checkout.tpl`:
```smarty
{foreach from=$paymentmethods item=method}
    <!-- Payment method option -->
{/foreach}
```

## 📱 Responsive Behavior

### Mobile (< 768px)
- Single column layout
- Sidebar summary moves below main content
- Touch-friendly buttons and form elements
- Simplified navigation

### Tablet (768px - 1024px)
- Two-column layout where appropriate
- Condensed sidebar
- Optimized form layouts

### Desktop (> 1024px)
- Full four-column grid with sidebar
- Sticky sidebar summary
- Enhanced hover effects
- Expanded form layouts

## 🔒 Security Considerations

### Form Validation
- Client-side validation with JavaScript
- Server-side validation through WHMCS
- CSRF protection through WHMCS tokens
- Input sanitization

### Payment Security
- PCI DSS compliance considerations
- SSL/TLS encryption requirements
- Secure payment gateway integration
- Sensitive data handling

## 🧪 Testing Checklist

### Functionality Testing
- [ ] Product selection and pricing display
- [ ] Configuration options update pricing
- [ ] Domain search and availability checking  
- [ ] Cart persistence across steps
- [ ] Payment method selection
- [ ] Form validation (client and server-side)
- [ ] Order completion flow

### Browser Testing
- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Safari
- [ ] Edge
- [ ] Mobile browsers (iOS Safari, Chrome Mobile)

### Accessibility Testing
- [ ] Keyboard navigation
- [ ] Screen reader compatibility
- [ ] Color contrast ratios
- [ ] Focus indicators
- [ ] ARIA labels and descriptions

## 🔧 Troubleshooting

### Common Issues

**Styling not loading properly:**
- Verify Tailwind CSS CDN is accessible
- Check for JavaScript errors blocking CSS
- Ensure proper file permissions

**WHMCS variables not displaying:**
- Verify correct variable names in templates
- Check WHMCS version compatibility
- Review error logs for template parsing issues

**Form submission errors:**
- Validate all required fields are present
- Check CSRF token implementation
- Review WHMCS cart configuration

**Mobile layout issues:**
- Test responsive breakpoints
- Verify touch event handling
- Check viewport meta tag

### Performance Optimization

**CSS Optimization:**
- Consider custom Tailwind build for production
- Implement CSS purging for unused classes
- Use CSS minification

**JavaScript Optimization:**
- Implement code splitting for large forms
- Use async loading for non-critical features
- Optimize images and assets

**Caching:**
- Enable template caching in WHMCS
- Implement browser caching headers
- Use CDN for static assets

## 📞 Support & Extension

### Extending Functionality
The template is designed to be easily extended with:
- Additional product configuration options
- Custom payment gateways
- Third-party integrations
- Enhanced validation rules
- Multi-language support

### Integration with WHMCS Modules
- Compatible with WHMCS product modules
- Supports domain registrar modules  
- Works with payment gateway modules
- Integrates with promotional code system

### Version Compatibility
- WHMCS 7.x and higher
- PHP 7.2+
- Modern browsers (ES6 support)

---

## 📝 Development Notes

This template follows WHMCS best practices and includes:
- Proper Smarty template syntax
- Secure form handling
- Responsive design principles
- Accessibility considerations
- Performance optimizations
- Extensible architecture

For additional customization or support, refer to the WHMCS documentation and developer resources.