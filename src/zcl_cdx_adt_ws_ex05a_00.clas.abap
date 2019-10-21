CLASS zcl_cdx_adt_ws_ex05a_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_cdx_adt_ws_ex05a_00 IMPLEMENTATION.


  METHOD main.
    TYPES: ty_orders TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.

    DATA(it_table) = VALUE ty_orders( ).

* >>> determin_new_orders
    SELECT partner AS order_nr,
           @sy-datum AS order_date,
           but000~partner AS customer
           FROM but000
           WHERE type = '1'
           INTO CORRESPONDING FIELDS of TABLE @it_table
           UP TO 10 ROWS.
    IF sy-subrc = 0.
    ENDIF.
* <<< determin_new_orders


* >>> adjust_ordernumber
    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<new_order>).
      <new_order>-order_nr = <new_order>-order_nr + sy-datum+0(4).
    ENDLOOP.
* <<< adjust_ordernumber


* >>> write_database
    MODIFY zcdx_order_00 FROM TABLE it_table.
    IF sy-subrc <> 0.
    ENDIF.
* <<< write_database

  ENDMETHOD.




ENDCLASS.
