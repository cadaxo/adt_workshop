CLASS zcl_cdx_adt_ws_ex05_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main.
  PROTECTED SECTION.
  PRIVATE SECTION.



ENDCLASS.



CLASS zcl_cdx_adt_ws_ex05_00 IMPLEMENTATION.

  METHOD main.
    TYPES: ty_orders TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.

    data lt_table2 type standard table of but000.

    DATA(lt_table) = VALUE ty_orders( ( currency = lt_table2[ partner = '123' ]-name_org1 )
                                      (  currency = 'USD' )
                                    ).

* >>> determin_new_orders
    SELECT partner AS order_nr,
           @sy-datum AS order_date
           FROM but000
           WHERE type = '1'
           ORDER BY PRIMARY KEY
           INTO CORRESPONDING FIELDS of TABLE @lt_table
           UP TO 10 ROWS.
    IF sy-subrc = 0.
    ENDIF.
* <<< determin_new_orders


* >>> adjust_ordernumber
    LOOP AT lt_table ASSIGNING FIELD-SYMBOL(<new_order>).
      <new_order>-order_nr    = <new_order>-order_nr + sy-datum+0(4).
      <new_order>-total_price = 500 * sy-tabix * sy-tabix.
      <new_order>-currency    = 'EUR'.
    ENDLOOP.
* <<< adjust_ordernumber


* >>> write_database
    MODIFY zcdx_order_00 FROM TABLE lt_table.
    IF sy-subrc <> 0.
    ENDIF.
* <<< write_database

  ENDMETHOD.

ENDCLASS.
