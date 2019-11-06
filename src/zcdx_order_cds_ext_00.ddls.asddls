@AbapCatalog.sqlViewAppendName: 'ZCDX_ORDER_E_00'
@EndUserText.label: 'Extension'
extend view ZCDX_ORDER_CDS_00 with ZCDX_ORDER_CDS_EXT_00 {
    total_price * 1 as TAX
}