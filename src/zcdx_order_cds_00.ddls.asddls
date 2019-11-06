@AbapCatalog.sqlViewName: 'ZCDX_ORDER_C_00'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Orders'
define view ZCDX_ORDER_CDS_00 as select from zcdx_order_00 
association [1..*] to zcdx_item_00 as _items on _items.order_nr = $projection.order_nr  {
   order_nr,  
   order_date,
   customer,  
   currency, 
   total_price,
    _items
}