{if !$json}<div class="shoppingcart">{/if}
<form class="cartwidget form-horizontal" method="post" action="{$SITEURL}/cart/">
{if $cartisempty}
    <p>Your shopping cart is empty.</p>
    {jojoHook hook="jojo_cart_empty"}
{else}
    <h3>Items in cart</h3>
    <table class="table table-condensed">
    <thead>
        <tr>
          <th></th>
          <th>Qty</th>
          <th>Price</th>
          <th>Total</th>
          <th>&nbsp;</th>
        </tr>
    </thead>
        {foreach from=$items key=k item=i}
        <tr id="row_{$i.id}" >
          <td class="item"><strong>{$i.name}</strong></td>
          <td class="quantity" style="white-space: nowrap">
            <input id="quantity[{$i.id}]" class="form-control cart-quantity" type="number" value="{$i.quantity}" size="2" name="quantity[{$i.id}]" min="{if $i.min_quantity}{$i.min_quantity}{else}1{/if}"{if $i.max_quantity} max="{$i.max_quantity}"{/if}/>
            <input id="remove_{$i.id}" type="checkbox" style="float:left; display: none;" value="remove" name="remove[{$i.id}]" />
           </td>
          <td class="price">{if $i.netprice != $i.price}<strike>{$i.price|string_format:"%01.2f"}</strike> {$i.netprice|string_format:"%01.2f"}{else}{$i.netprice|string_format:"%01.2f"}{/if}</td>
          <td class="price cart-linetotal"><span>{$i.linetotal|string_format:"%01.2f"}</span></td>
          <td><a href="cart/remove/{$i.code}" class="widget-remove" onclick="$('#remove_{$i.id}').attr('checked', 'checked'); $('form.cartwidget').trigger('submit'); return false;" title="Remove">x</a></td>
        </tr>
      {/foreach}
    </table>
    {if $freight}<div id="cart-freight" class="clearfix">Freight: {$currencysymbol}<span>{$freight|string_format:"%01.2f"}</span></div>
    {/if}
    <div id="cart-total" class="clearfix">Total: {$currencysymbol}<span>{$total|string_format:"%01.2f"}</span></div>
    
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
      <div id="cartfunctions">
      <span id="updatelink"><a href="{$SITEURL}/cart/" class="btn btn-default btn-small" name="update" id="updatecart" title="Updates the totals if you have modified quantities for any items">Update</a></span>{if $OPTIONS.cart_show_empty=='yes'}<a href="{$SITEURL}/cart/empty" class="btn btn-default btn-small" name="empty" id="emptycart" title="Removes all items from your cart" >Empty cart</a>{/if}
      </div>
      <a id="checkoutbutton" class="btn btn-primary move-up" href="{$SITEURL}/cart/">##Checkout##</a>
    </div>
{/if}
<input type="hidden" name="cart-item-total" id="cart-item-total" value="{count($items);}" />
</form>
{if !$json}</div>{/if}