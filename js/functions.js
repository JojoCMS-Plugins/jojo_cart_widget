function showUpdate() {
            $("#updatelink").show();
            $("#checkout").hide();
}

function cartWidgetSubmit(e) {
        /* Get the form data */
        data = $('.cartwidget input, .cartwidget select').serializeArray();
        /* Find out what button was clicked - with various failovers for different browsers*/
        if(e.explicitOriginalTarget) submitValue = e.explicitOriginalTarget.id;
        else if(e.relatedTarget) submitValue = e.relatedTarget.id;
        else submitValue = document.activeElement.id;

        if (submitValue =='add') {
            data[data.length] = {name: submitValue, value: "Add to cart" };
        } else {
            data[data.length] = {name: 'update', value: "Update" };
        }
        /* Get the page in the background the reload this page */
        jojo_cart_widget_update(data);
        /* Don't go to the cart page */
        return false;

}

function cartWidgetEmpty(e) {
        $(this).html('Emptying...');
        data = $('.cartwidget input, .cartwidget select').serializeArray();
        data[data.length] = {name: 'empty', value: "Empty cart" };
        /* Get the page in the background the reload this page */
        jojo_cart_widget_update(data);
        /* Don't go to the cart page */
        return false;
}

function cartWidgetUpdate(e) {
        $(this).html('Updating cart...');
        data = $('.cartwidget input, .cartwidget select').serializeArray();
        data[data.length] = {name: 'update', value: "Update" };
        /* Get the page in the background the reload this page */
        $.get(this.href, {}, function() {jojo_cart_widget_update(data); });
        /* Don't go to the cart page */
        return false;
}

function jojo_cart_widget_update(data) {
    $('.shoppingcart').html('<img src="images/ajax-loader.gif" alt="Updating"/>');
    $.post('json/jojo_cart_widget.php', data,
            function(data) {
               if ($('.cartItemTotal').length>0) {
                    $.post('json/cart_item_total_update.php', data,
                        function(data) {
                                $('.cartItemTotal').html(data[0]);
                                $('.cartTotal').html(data[1]);
                        },
                        "json"
                    );
                    
                }
                if ($('.shoppingcart').length>0) {
                    $('.shoppingcart').html(data);
                }
                $('.cartwidget').unbind('submit');
                $('.cartwidget').bind('submit', cartWidgetSubmit);
                $('#emptycart').bind('click', cartWidgetEmpty);
                $('#updatecart').bind('click', cartWidgetUpdate);
                $("#updatelink").hide();
                $('input.cart-widget-quantity').keyup(function(){ $('form.cartwidget').submit(); });
                $('select.cart-widget-quantity').change(function(){ $('form.cartwidget').submit(); });
 
            },
            "json"
    );
}

$(document).ready(function() {
    if ($('.shoppingcart')) {
        $("#updatelink").hide();
        $('#emptycart').bind('click', cartWidgetEmpty);
        $('#updatecart').bind('click', cartWidgetUpdate)
        $('.cartwidget').bind('submit', cartWidgetSubmit);
        var keyupdelay;
        $('input.cart-widget-quantity').keyup(function(){
            clearTimeout(keyupdelay);
            keyupdelay = setTimeout(function() {
                $('form.cartwidget').submit();
            }, 300);
        });
        $('select.cart-widget-quantity').change(function(){
            $('form.cartwidget').submit();
        });
    }
});
