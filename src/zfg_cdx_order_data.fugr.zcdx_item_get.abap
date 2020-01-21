FUNCTION ZCDX_ITEM_GET.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_ORDER_NR) TYPE  ZCDX_ITEM_00-ORDER_NR
*"     VALUE(I_POS_NR) TYPE  ZCDX_ITEM_00-ORDER_POSNR
*"  EXPORTING
*"     VALUE(E_ITEM) TYPE  ZCDX_ITEM_00
*"----------------------------------------------------------------------
  e_item = zcl_cdx_order_data=>get_item( i_order_nr = i_order_nr
                                         i_pos_nr   = i_pos_nr ).

ENDFUNCTION.
