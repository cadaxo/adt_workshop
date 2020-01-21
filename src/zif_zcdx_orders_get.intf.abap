interface ZIF_ZCDX_ORDERS_GET
  public .


  types:
    MANDT type C length 000003 .
  types:
    ZCDX_ORDER_NR_00 type C length 000010 .
  types:
    BU_PARTNER type C length 000010 .
  types:
    ZCDX_ORDER_CURRENCY_00 type C length 000005 .
  types:
    ZCDX_ORDER_TOTAL_PRICE_00 type P length 9  decimals 000002 .
  types:
    begin of ZCDX_ORDER_00,
      MANDT type MANDT,
      ORDER_NR type ZCDX_ORDER_NR_00,
      ORDER_DATE type DATS,
      CUSTOMER type BU_PARTNER,
      CURRENCY type ZCDX_ORDER_CURRENCY_00,
      TOTAL_PRICE type ZCDX_ORDER_TOTAL_PRICE_00,
    end of ZCDX_ORDER_00 .
  types:
    ZCDX_TT_ORDERS                 type standard table of ZCDX_ORDER_00                  with non-unique default key .
endinterface.
