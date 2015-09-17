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

function cartWidgetUpdate(e) {
        $(this).html('Updating cart...');
        data = $('.cartwidget input, .cartwidget select').serializeArray();
        data[data.length] = {name: 'update', value: "Update" };
        /* Get the page in the background the reload this page */
        $.get(this.href, {}, function() {jojo_cart_widget_update(data); });
        /* Don't go to the cart page */
        return false;
}

function cartWidgetToggle() {
        $('.shoppingcartwidget').toggleClass('open');
        return false;
};

function cartWidgetClose() {
        $('.shoppingcartwidget').removeClass('open');
        return false;
};

function jojo_cart_widget_update(data) {
    $('.shoppingcartwidget').html('<img src="images/ajax-loader.gif" alt="Updating"/>');
    $.post('json/jojo_cart_widget.php', data,
            function(data) {
                if ($('.shoppingcartwidget').length>0) {
                    $('.shoppingcartwidget').html(data);
                }
                $('.cartwidget').unbind('submit');
                $('.cartwidget').bind('submit', cartWidgetSubmit);
                $('#updatecart').bind('click', cartWidgetUpdate);
                $('.cartWidgetClose').bind('click', cartWidgetClose);
                $("#updatelink").hide();
                $('input.cart-quantity').bind('keyup input mousewheel', function(){
                    var rowid = $(this).closest('tr').attr('id');
                    var id = $(this).attr('id');
                    var code = id.replace(/quantity\[(.*?)\]/ig, "$1");
                    $.getJSON('json/jojo_cart_change_quantity.php', {qty: $(this).val(), code: code, rowid: rowid}, change_quantity_callback);
                });
                $('select.cart-quantity').change(function(){
                    var rowid = $(this).closest('tr').attr('id');
                    var id = $(this).attr('id');
                    var code = id.replace(/quantity\[(.*?)\]/ig, "$1");
                    $.getJSON('json/jojo_cart_change_quantity.php', {qty: $(this).val(), code: code, rowid: rowid}, change_quantity_callback);
                });
               $('#applyDiscount').bind('click', function(){
                var code = $('#discountCode').val();
                $.getJSON('json/jojo_cart_change_quantity.php', {discount: code}, change_quantity_callback);
                $('#updatecart').click();
                return false;
              });
           },
            "json"
    );
    if ($('.cartItemTotal').length>0) {
        $.post('json/cart_item_total_update.php', data,
            function(data) {
                    $('.cartItemTotal').html(data[0]);
                    $('.cart-total span').html(data[1]);
            },
            "json"
        );
    
    }
}


$(document).ready(function() {
    if ($('.shoppingcartwidget')) {
        $('.cartWidgetToggle').bind('click', cartWidgetToggle);
        $('#updatecart').bind('click', cartWidgetUpdate);
        $('#updatecart').click();
    }
});
