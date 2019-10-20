@AbapCatalog.sqlViewName: 'ZCDX_ORDER_00_CV'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Orders'
define view ZCDX_ORDER_00_C as select from zcdx_order_00
inner join but000
    on zcdx_order_00.customer = but000.partner {
    zcdx_order_00.order_nr,
    zcdx_order_00.order_date,
    zcdx_order_00.customer,
    but000.name_last,
    but000.name_first
}