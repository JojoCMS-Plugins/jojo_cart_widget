<?php

header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past

/* Add to cart */
foreach(Jojo::getFormData('add', array()) as $id => $add) {
    call_user_func(array(Jojo_Cart_Class, 'addToCart'), $id);
}

/* Update Quantities */
if (Jojo::getFormData('update')) {
    foreach (Jojo::getFormData('quantity', array()) as $id => $qty) {
        call_user_func(array(Jojo_Cart_Class, 'setQuantity'), $id, $qty);
    }
    foreach (Jojo::getFormData('remove', array()) as $id => $remove) {
        call_user_func(array(Jojo_Cart_Class, 'removeFromCart'), $id);
    }
}

/* Empty cart */
if (Jojo::getFormData('empty')) {
    call_user_func(array(Jojo_Cart_Class, 'emptyCart'));
}

/* Discount Code */
if (Jojo::getFormData('discountcode')) {
    call_user_func(array(Jojo_Cart_Class, 'applyDiscountCode'), Jojo::getFormData('discountcode'));
}


$html = str_replace(array("\n", "\r", '  '), '', jojo_plugin_Jojo_cart_widget::getWidgetContent('json'));
$html = preg_replace("#<script type='text\/javascript'>(.*)</script>#isU", '', $html);
$res = json_encode($html);
header('Content-Length: ' . strlen($res));
echo $res;
exit;
