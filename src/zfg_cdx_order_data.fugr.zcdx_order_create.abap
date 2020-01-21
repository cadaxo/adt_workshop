FUNCTION ZCDX_ORDER_CREATE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ORDER) TYPE  ZCDX_ORDER_00
*"  EXPORTING
*"     VALUE(E_ORDER) TYPE  ZCDX_ORDER_00
*"----------------------------------------------------------------------
  INSERT zcdx_order_00 FROM i_order.

ENDFUNCTION.
