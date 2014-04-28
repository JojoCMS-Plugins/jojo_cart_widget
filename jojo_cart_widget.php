<?php
/**
 *                    Jojo CMS
 *                ================
 *
 * Copyright 2008 JojoCMS
 *
 * See the enclosed file license.txt for license information (LGPL). If you
 * did not receive this file, see http://www.fsf.org/copyleft/lgpl.html.
 *
 * @author  Mike Cochrane <mikec@mikenz.geek.nz>
 * @author  Tom Dale <tom@gardyneholt.co.nz>
 * @license http://www.fsf.org/copyleft/lgpl.html GNU Lesser General Public License
 * @link    http://www.jojocms.org JojoCMS
 */

class jojo_plugin_jojo_cart_widget extends JOJO_Plugin
{
    /**
     * Filter to Insert the cart widget into the page output
     */
    static function cart_widget($content)
    {
        if (strpos($content, '[[shopping_cart]]') === false) {
            return $content;
        }
        return str_replace('[[shopping_cart]]', self::getWidgetContent(), $content);
    }

    /**
     * Returns the html content of the widget
     */
    static function getWidgetContent($json='')
    {
        global $smarty;

        /* Initialize cart object */
        $cart = call_user_func(array(Jojo_Cart_Class, 'getCart'));
        $cart->items = Jojo::applyFilter('jojo_cart_sort', $cart->items);

        if (count($cart->items)) {
            $smarty->assign('items', $cart->items);
            foreach ($cart->items as $i)  {
                $linetotals[] = $i['linetotal'];
            }
            $total = array_sum($linetotals);
            $smarty->assign('total', $total);
            
            $smarty->assign('numprods', count($cart->items));
            $smarty->assign('numitems',  call_user_func(array(Jojo_Cart_Class, 'getNumItems'), $cart->items));
            $smarty->assign('freight', call_user_func(array(Jojo_Cart_Class, 'getFreight')));

            $smarty->assign('items', $cart->items);
            $currency = call_user_func(array(Jojo_Cart_Class, 'getCartCurrency'));
            $smarty->assign('currency', $currency);
            $smarty->assign('currencysymbol', call_user_func(array(Jojo_Cart_Class, 'getCurrencySymbol'), $currency));
            /* are we using the discount code functionality? No need to show the UI if the discount table is empty */
            $data = Jojo::selectRow("SELECT COUNT(*) AS numdiscounts FROM {discount}");
            $usediscount = $data['numdiscounts'] > 0 ? true : false;
            $smarty->assign('usediscount', $usediscount);
            $smarty->assign('discount', $cart->discount);

            if (isset($cart->errors))  {
                $smarty->assign('errors', $cart->errors);
                unset($cart->errors);
            }
        } else {
            $smarty->assign('cartisempty', true);
        }

        $smarty->assign('json', $json);
        return $smarty->fetch('jojo_cart_widget.tpl');
    }
}

