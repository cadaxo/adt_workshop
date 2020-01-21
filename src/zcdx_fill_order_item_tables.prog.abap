REPORT zcdx_fill_order_item_tables.

CLASS lcl_worker DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS fill_tables.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_worker IMPLEMENTATION.


  METHOD fill_tables.
    TYPES: ty_orders TYPE STANDARD TABLE OF zcdx_order_00 WITH DEFAULT KEY.
    TYPES: ty_items  TYPE STANDARD TABLE OF zcdx_item_00  WITH DEFAULT KEY.

    DATA(orders) = VALUE ty_orders( ).

    SELECT partner AS order_nr,
           partner AS customer,
           @sy-datum AS order_date
           FROM but000
           WHERE type = '1'
           ORDER BY PRIMARY KEY
           INTO CORRESPONDING FIELDS of TABLE @orders
           UP TO 10 ROWS.
    LOOP AT orders ASSIGNING FIELD-SYMBOL(<new_order>).
      <new_order>-order_nr    = |{ CONV zcdx_order_nr_00( <new_order>-order_nr + sy-datum+0(4) ) ALPHA = IN }|.
      <new_order>-order_date  = <new_order>-order_date - sy-tabix.
      <new_order>-total_price = 500 * sy-tabix + sy-tabix.
      <new_order>-currency    = 'EUR'.
    ENDLOOP.

    LOOP AT orders ASSIGNING <new_order> FROM 1 TO lines( orders ).
      APPEND <new_order> TO orders ASSIGNING FIELD-SYMBOL(<new_order_2>).
      <new_order_2>-order_nr  = |{ CONV zcdx_order_nr_00( <new_order_2>-order_nr + 5000 ) ALPHA = IN }|.
      IF <new_order_2>-total_price < 4000.
        <new_order_2>-total_price = <new_order_2>-total_price + 30.
      ELSE.
        <new_order_2>-total_price = <new_order_2>-total_price * '2.5'.
      ENDIF.
    ENDLOOP.

* Error Date eg SQL Expressions or OData null
    APPEND <new_order> TO orders ASSIGNING <new_order_2>.
    <new_order_2>-order_nr = |{ CONV zcdx_order_nr_00( <new_order_2>-order_nr + 6000 ) ALPHA = IN }|.
    CLEAR <new_order_2>-order_date.

    DATA(items) = VALUE ty_items( FOR <order> IN orders
                                    FOR i = 0 UNTIL i >= <order>-total_price / 500
                                      ( order_nr      = <order>-order_nr
                                        order_posnr   = condense( conv zcdx_order_posnr_00( i + 1 ) )
                                        product_id    = i + 200
                                        quantity      = 1
                                        quantity_unit = 'STK'
                                        price_per_pos = 500
                                      )
                                ).

    DELETE FROM zcdx_order_00.
    DELETE FROM zcdx_item_00.
    MODIFY zcdx_order_00 FROM TABLE orders.
    MODIFY zcdx_item_00 FROM TABLE items.

  ENDMETHOD.

ENDCLASS.



START-OF-SELECTION.

  lcl_worker=>fill_tables( ).

  WRITE: 'Tables zcdx_order_00 and zcdx_item_00 filled'.
