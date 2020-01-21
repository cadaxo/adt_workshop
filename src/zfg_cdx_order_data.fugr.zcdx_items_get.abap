FUNCTION ZCDX_ITEMS_GET.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ORDER_NR) TYPE  ZCDX_ORDER_00-ORDER_NR
*"  EXPORTING
*"     VALUE(E_ITEMS) TYPE  ZCDX_TT_ITEMS
*"----------------------------------------------------------------------
  E_items = zcl_cdx_order_data=>get_items( i_order_nr ).


ENDFUNCTION.
