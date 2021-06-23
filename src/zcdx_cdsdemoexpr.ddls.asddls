@AbapCatalog.sqlViewName: 'ZCDXDEMOEXPRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDX Demo Expressions'
define view ZCDX_CDSDEMOEXPR as select from zcdx_sqlcdemo {

    keyval,
    float_a,
    fltp_to_dec(float_a as abap.dec(10,2)) as fltp_to_dec,
    fltp_to_dec(float_a as abap.curr(10,2)) as fltp_to_curr,
    fltp_to_dec(float_a as abap.quan(10,2)) as fltp_to_quan,    
    abap_system_timezone( $session.client, 'NULL' ) as system_timezone,
    abap_user_timezone( $session.user, $session.client, 'NULL' ) as user_timezone,
    timestamp_a,
    tstmp_to_dats(timestamp_a, 'CET', $session.client, 'INITIAL' ) as timestamp_to_dats,
    tstmp_to_tims(timestamp_a, 'CET', $session.client, 'INITIAL' ) as timestamp_to_tims,
    tstmp_to_dst(timestamp_a, 'CET', $session.client, 'INITIAL' ) as timestamp_to_dst,
    date_a,
    time_a,
    dats_tims_to_tstmp(date_a, time_a, 'CET', $session.client, 'INITIAL') as date_time_to_timestamp
} 
