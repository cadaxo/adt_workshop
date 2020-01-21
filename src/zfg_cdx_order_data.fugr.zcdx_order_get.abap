FUNCTION ZCDX_ORDER_GET.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ORDER_NR) TYPE  ZCDX_ORDER_00-ORDER_NR
*"  EXPORTING
*"     VALUE(E_ORDER) TYPE  ZCDX_ORDER_00
*"----------------------------------------------------------------------
  e_order = zcl_cdx_order_data=>get_order( i_order_nr = i_order_nr ).

ENDFUNCTION.
