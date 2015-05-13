<?php

$total = 0;
$itemTotal=0;
if (!Jojo::getFormData('empty')) {
    $cart = call_user_func(array(Jojo_Cart_Class, 'getCart'));
    $itemTotal = call_user_func(array(Jojo_Cart_Class, 'getNumItems'), $cart->items);
    $currency = call_user_func(array(Jojo_Cart_Class, 'getCartCurrency'), $cart->token);
    $currencysymbol = call_user_func(array(Jojo_Cart_Class, 'getCurrencySymbol'), $currency);
    $total = call_user_func(array(Jojo_Cart_Class, 'total'));
    $total = $total ? number_format($total, 2) : 0;
}
$res = json_encode(array($itemTotal, $total));
header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header('Content-Length: ' . strlen($res));
echo $res;
exit;
