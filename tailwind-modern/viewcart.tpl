{*
 * viewcart.tpl - Cart view that handles both product selection and summary
 * This file is loaded when users visit the cart
 * Shows products page if empty cart, summary page if items in cart
 *}

{if $products || $domains || $cartitems}
    {include file="pages/summary.tpl"}
{else}
    {include file="pages/products.tpl"}
{/if}