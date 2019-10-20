CLASS zcl_cdx_adt_ws_ex05_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main_b.
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: ty_orders TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.
    METHODS determin_new_orders
      CHANGING
        c_new_orders TYPE zcl_cdx_adt_ws_ex05_00=>ty_orders.
    METHODS adjust_ordernumber
      CHANGING
        c_new_orders TYPE zcl_cdx_adt_ws_ex05_00=>ty_orders.
    METHODS write_database
      IMPORTING
        i_new_orders TYPE zcl_cdx_adt_ws_ex05_00=>ty_orders.
    METHODS main_new.

ENDCLASS.



CLASS zcl_cdx_adt_ws_ex05_00 IMPLEMENTATION.

  METHOD main_new.

    DATA(new_orders) = VALUE ty_orders( ).

    determin_new_orders( CHANGING c_new_orders = new_orders ).

    adjust_ordernumber( CHANGING c_new_orders = new_orders ).

    write_database( new_orders ).

  ENDMETHOD.

METHOD main_b.
    TYPES: ty_orders TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.

    DATA(it_table) = VALUE ty_orders( ).

* >>> determin_new_orders
    " Hole die letzten 10 angelegten Geschäftspartner
    SELECT partner AS order_nr,
           @sy-datum AS order_date,
           but000~partner as customer
           FROM but000
           WHERE type = '1'
           INTO CORRESPONDING FIELDS of TABLE @it_table
           UP TO 10 ROWS.
    IF sy-subrc = 0.
    ENDIF.
* <<< determin_new_orders


* >>> adjust_ordernumber
    " Ändere die Ordernumber
    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<new_order>).
      <new_order>-order_nr = <new_order>-order_nr + sy-datum+0(4).
    ENDLOOP.
* <<< adjust_ordernumber


* >>> write_database
    " Scheibe in die Datenbank
    MODIFY zcdx_order_00 FROM TABLE it_table.
    IF sy-subrc <> 0.
    ENDIF.
* <<< write_database

  ENDMETHOD.

  METHOD write_database.

    "Scheibe in die Datenbank
    MODIFY zcdx_order_00 FROM TABLE i_new_orders.
    IF sy-subrc <> 0.
    ENDIF.

  ENDMETHOD.



  METHOD adjust_ordernumber.

    "Ändere die Ordernumber
    LOOP AT c_new_orders ASSIGNING FIELD-SYMBOL(<new_order>).
      <new_order>-order_nr = <new_order>-order_nr + sy-datum+0(4).
    ENDLOOP.

  ENDMETHOD.



  METHOD determin_new_orders.

    " Hole die letzten 10 angelegten Geschäftspartner
    SELECT partner AS order_nr,
           @sy-datum AS order_date
           FROM but000
           WHERE type = '1'
           INTO CORRESPONDING FIELDS of TABLE @c_new_orders
           UP TO 10 ROWS.
    IF sy-subrc = 0.
    ENDIF.

  ENDMETHOD.



ENDCLASS.
