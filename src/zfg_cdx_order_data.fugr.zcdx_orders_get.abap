FUNCTION ZCDX_ORDERS_GET.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(E_ORDERS) TYPE  ZCDX_TT_ORDERS
*"----------------------------------------------------------------------
  e_orders = zcl_cdx_order_data=>get_orders( ).



ENDFUNCTION.
