CLASS zcl_cdx_order_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: typ_orders        TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.
    TYPES: typ_orders_string TYPE STANDARD TABLE OF string WITH DEFAULT KEY.
    TYPES: BEGIN OF typ_order_nr,
             order_nr TYPE c LENGTH 10,
           END OF typ_order_nr,
           typ_orders_nr TYPE STANDARD TABLE OF typ_order_nr WITH DEFAULT KEY.
    TYPES: typ_items TYPE STANDARD TABLE OF zcdx_item_00 WITH DEFAULT KEY.
    CLASS-METHODS get_orders RETURNING VALUE(e_orders) TYPE typ_orders.
    CLASS-METHODS get_order IMPORTING i_order_nr     TYPE zcdx_order_00-order_nr
                            RETURNING VALUE(e_order) TYPE zcdx_order_00.
    CLASS-METHODS get_orders_string RETURNING VALUE(e_orders_string) TYPE typ_orders_string.
    CLASS-METHODS get_orders_nr RETURNING VALUE(e_orders_nr) TYPE typ_orders_nr.

    CLASS-METHODS get_items IMPORTING i_order_nr     TYPE zcdx_item_00-order_nr
                            RETURNING VALUE(e_items) TYPE typ_items.
    CLASS-METHODS get_item IMPORTING i_order_nr    TYPE zcdx_item_00-order_nr
                                     i_pos_nr      TYPE zcdx_item_00-order_posnr
                           RETURNING VALUE(e_item) TYPE zcdx_item_00.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CDX_ORDER_DATA IMPLEMENTATION.


  METHOD get_item.
    SELECT SINGLE * FROM zcdx_item_00 WHERE order_nr = @i_order_nr AND order_posnr = @i_pos_nr INTO @e_item.
  ENDMETHOD.


  METHOD get_items.

    IF i_order_nr CO '0 '.
      SELECT * FROM zcdx_item_00 INTO TABLE @e_items.
    ELSE.
      SELECT * FROM zcdx_item_00 WHERE order_nr = @i_order_nr INTO TABLE @e_items.
    ENDIF.

  ENDMETHOD.


  METHOD get_order.
    SELECT SINGLE * FROM zcdx_order_00 WHERE order_nr = @i_order_nr INTO  @e_order.
  ENDMETHOD.


  METHOD get_orders.
    SELECT * FROM zcdx_order_00 INTO TABLE @e_orders.
  ENDMETHOD.


  METHOD get_orders_nr.
    SELECT order_nr FROM zcdx_order_00 INTO TABLE @e_orders_nr.
  ENDMETHOD.


  METHOD get_orders_string.
    DATA l_order LIKE LINE OF e_orders_string.
    SELECT * FROM zcdx_order_00 INTO TABLE @DATA(lt_data).
    LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<data>).
      l_order = <data>-order_nr && ';' && <data>-customer.
      APPEND l_order TO e_orders_string.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
