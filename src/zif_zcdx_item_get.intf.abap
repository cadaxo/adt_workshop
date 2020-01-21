interface ZIF_ZCDX_ITEM_GET
  public .


  types:
    MANDT type C length 000003 .
  types:
    ZCDX_ORDER_NR_00 type C length 000010 .
  types:
    ZCDX_ORDER_POSNR_00 type C length 000010 .
  types:
    ZCDX_PRODUCT_ID_00 type C length 000010 .
  types:
    ZCDX_ORDER_QUANTITY_00 type P length 3  decimals 000000 .
  types:
    ZCDX_ORDER_QUANTITY_UNIT_00 type C length 000002 .
  types:
    ZCDX_PRODUCT_PRICE_00 type P length 9  decimals 000002 .
  types:
    begin of ZCDX_ITEM_00,
      MANDT type MANDT,
      ORDER_NR type ZCDX_ORDER_NR_00,
      ORDER_POSNR type ZCDX_ORDER_POSNR_00,
      PRODUCT_ID type ZCDX_PRODUCT_ID_00,
      QUANTITY type ZCDX_ORDER_QUANTITY_00,
      QUANTITY_UNIT type ZCDX_ORDER_QUANTITY_UNIT_00,
      PRICE_PER_POS type ZCDX_PRODUCT_PRICE_00,
    end of ZCDX_ITEM_00 .
endinterface.
