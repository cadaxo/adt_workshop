interface ZIF_CDX_ADT_WS_EX05A_DB_00
  public .
  TYPES: ty_orders TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.
  METHODS determin_new_orders
    CHANGING
      c_new_orders TYPE ZIF_CDX_ADT_WS_EX05A_DB_00=>ty_orders.

endinterface.
