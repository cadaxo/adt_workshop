class ZCL_CDX_ORDER_DATA definition
  public
  final
  create public .

public section.

  types:
    TYP_ORDERS type standard table of zcdx_order_00,
    typ_orders_string type standard table of string,
    begin of typ_order_nr,
       order_nr type c length 10,
    end of typ_order_nr,
    typ_orders_nr type STANDARD TABLE OF typ_order_nr.
  types:
    TYP_items type standard table of zcdx_order_00 .

  class-methods GET_ORDERS
    exporting
      !E_ORDERS type TYP_ORDERS.
  class-methods get_orders_string
     exporting
       e_orders_string type typ_orders_string.
  class-methods get_orders_nr
    exporting
      e_orders_nr type typ_orders_nr.
protected section.
private section.
ENDCLASS.



CLASS ZCL_CDX_ORDER_DATA IMPLEMENTATION.


  method GET_ORDERS.
    select * from zcdx_order_00 into table @e_orders.
  endmethod.


  method get_orders_nr.
     select order_nr from zcdx_order_00 into table @e_orders_nr.
  endmethod.


  method get_orders_string.
     data l_order like line of e_orders_string.
     select * from zcdx_order_00 into table @data(lt_data).
     loop at lt_data ASSIGNING field-symbol(<data>).
        l_order = <data>-order_nr && ';' && <data>-customer.
        append l_order to e_orders_string.
     endloop.
  endmethod.
ENDCLASS.
