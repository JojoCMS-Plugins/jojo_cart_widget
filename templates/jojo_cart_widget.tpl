{if !$json}<div class="shoppingcart">{/if}
<form class="cartwidget" method="post" action="{$SITEURL}/cart/">
{if $cartisempty}
    Your shopping cart is empty.
    {jojoHook hook="jojo_cart_empty"}
{else}
    <h3>Items in cart</h3>
    <table style="border-collapse: collapse">
        <tr>
          <th style="text-align: left;">Item</th>
          <th>Qty</th>
          <th>Price</th>
          <th>Total</th>
        </tr>
        {foreach from=$items key=k item=i}
        <tr>
          <td style="text-align: left;"><strong>{$i.name}</strong></td>
          <td class="quantity" style="white-space: nowrap">
            <input id="quantity_{$i.id}" class="cart-widget-quantity" type="text" value="{$i.quantity}" size="2" onfocus="showUpdate()" name="quantity[{$i.id}]"/>
            <input id="remove_{$i.id}" type="checkbox" style="float:left; display: none;" value="remove" name="remove[{$i.id}]" />
           </td>
          <td class="price">{if $i.netprice != $i.price}<strike>{$i.price|string_format:"%01.2f"}</strike> {$i.netprice|string_format:"%01.2f"}{else}{$i.netprice|string_format:"%01.2f"}{/if}</td>
          <td class="price">{$i.linetotal|string_format:"%01.2f"}</td>
          <td style="border: none">
            <a href="cart/remove/{$i.code}" class="widget-remove" onclick="$('#remove_{$i.id}').attr('checked', 'checked'); $('form.cartwidget').trigger('submit'); return false;" title="Remove">x</a>
          </td>
        </tr>
      {/foreach}
    </table>
    <div id="cart-widget-total">
        Total: {$currencysymbol}{$total|string_format:"%01.2f"}
    </div>
    <div id="cart-widget-buttons">
      <span id="updatelink"><a href="{$SITEURL}/cart/" class="submitbutton" name="update" id="updatecart" title="Updates the totals if you have modified quantities for any items">Update</a> | </span><a href="{$SITEURL}/cart/empty" class="submitbutton" name="empty" id="emptycart" title="Removes all items from your cart" >Empty cart</a>
    </div>
{if $usediscount}
    <h4>Discount Code?</h4>
    <div id="widget_discount">
       <input name='discountcode' type="text" size="8" value="{if $discount.code != ''}{$discount.code}{/if}"/><input type="submit" value="Apply" name="discount" id="discount" onclick="document.activeElement=this" />
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
    <h4 class="links">&gt; <a href="{$SITEURL}/cart/checkout">Go to Checkout</a></h4>
{/if}
</form>
{if !$json}</div>{/if}