{if !$json}<div class="shoppingcart shoppingcartwidget">{/if}
<a class="close cartWidgetClose" href="#">&times;</a>
<form class="cartwidget" method="post" action="{$SITEURL}/cart/">
{if $cartisempty}
    <p><strong>##Your shopping cart is empty##.</strong></p>
    {jojoHook hook="jojo_cart_empty"}
{else}
    <div class="row hidden-xs titles">
        <div class="cart-item col-sm-5">##Item##</div>
        <div class="cart-quantity col-sm-4">##Qty##</div>
        <div class="cart-linetotal col-sm-2">##Total##</div>
        <div class="col-sm-1">&nbsp;</div>
    </div>
    {foreach from=$items key=k item=i}
    <div id="row_{$i.id}" class="row cart-items">
        <div class="item-wrap clearfix">
            <div class="cart-item col-sm-5 col-xs-11"><strong>{$i.name}</strong>{if $i.description}<br /><small>{$i.description}</small>{/if}</div>
            <div class="cart-quantity col-sm-4 col-xs-8">
                <input id="quantity[{$i.id}]" class="form-control cart-quantity" type="number" value="{$i.quantity}" size="2" name="quantity[{$i.id}]" min="{if $i.min_quantity}{$i.min_quantity}{else}1{/if}"{if $i.max_quantity} max="{$i.max_quantity}"{/if}/>
                <input id="remove_{str_replace(' ', '+',$i.id);}" type="checkbox" style="float:left; display: none;" value="remove" name="remove[{$i.id}]" />
                <span class="price"> @{$currencysymbol}{if $i.netprice != $i.price}<strike>{$i.price|string_format:"%01.2f"}</strike> {$i.netprice|string_format:"%01.2f"}{else}{$i.netprice|string_format:"%01.2f"}{/if}</span>
            </div>
            <div class="cart-linetotal col-sm-2 col-xs-4">{$currencysymbol}<span>{$i.linetotal|string_format:"%01.2f"}</span></div>
            <div class="cart-remove col-sm-1"><a href="{$SITEURL}/cart/remove/{$i.code}" class="widget-remove close" onclick="$('#remove_{regex_replace str_replace(' ', '+',$i.id) '/([\#\;\&\,\.\+\*\~\'\:\"\!\^\$\[\]\(\)\=\>\|\/\@])/' '\\\\\\\\\$1'}').attr('checked', 'checked'); $('form.cartwidget').trigger('submit'); return false;" title="Remove">x</a></div>
        </div>
    </div>
  {/foreach}
   <div class="row">
        <div class="col-sm-11"  id="cart-freight">##Freight## {if $order.freight}(##based on current delivery address##): {$order.currency_symbol|default:' '}<span>{$order.freight|string_format:"%01.2f"}</span>{else}(##to be calculated##){/if}
       {if $order.surcharge}<div id="cart-surcharge">##{$order.surchargedescription}##: {$order.currency_symbol|default:' '}<span>{$order.surcharge|string_format:"%01.2f"}</span></div>
       {/if}
       </div>
   </div>
    <div class="row">
        <div class="col-sm-11 cart-total">
         ##Total##: {$order.currency|default:$OPTIONS.cart_default_currency}{$order.currency_symbol|default:' '}<span>{$order.amount|string_format:"%01.2f"}</span>
        {if $OPTIONS.cart_tax_amount}
        {if $order.apply_tax}<p class="note">##includes## {$OPTIONS.cart_tax_amount}% {$OPTIONS.cart_tax_name|default:'Tax'}</p>
        {else}<p class="note">##excluding## {$OPTIONS.cart_tax_amount}% {$OPTIONS.cart_tax_name|default:'Tax'} (##if applicable##)</p>
        {/if}{/if}
        </div>
    </div>
    
{if $usediscount}
    <div id="widget_discount" class="form-controls">
        <label>Discount Code?</label>
       <div class="input-append">
        <input class="text inline" name='discountcode' type="text" size="6" value="{if $discount.code != ''}{$discount.code}{/if}"/>
        <button name="discount" class="btn btn-default" onclick="document.activeElement=this">Apply</button>
        </div>
    </div>
{/if}
{if $errors}
    <div class="errors">
    <ul>
    {foreach from=$errors item=e}
      <li style="color: red">{$e}</li>
    {/foreach}
    </ul>
    </div>
{/if}
    
    <div id="cart-widget-buttons" >
      <div id="cartfunctions" class="form-group">
      <span id="updatelink"><a href="{$SITEURL}/cart/" class="btn btn-default btn-small" name="update" id="updatecart" title="Updates the totals if you have modified quantities for any items">Update</a></span>{if $OPTIONS.cart_show_empty=='yes'}<a href="{$SITEURL}/cart/empty" class="btn btn-default btn-small" name="empty" id="emptycart" title="Removes all items from your cart" >Empty cart</a>{/if}
      </div>
      <a id="checkoutbutton" class="btn btn-primary move-up" href="{$SITEURL}/cart/checkout/">##Checkout##</a>
    </div>
{/if}
<input type="hidden" name="cart-item-total" id="cart-item-total" value="{count($items);}" />
</form>
{if !$json}</div>{/if}