CLASS zcl_zcdx_orders_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zcdx_orders_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS eitemsset_get_entityset REDEFINITION.
    METHODS eordersset_get_entityset REDEFINITION.
    METHODS eitemsset_delete_entity REDEFINITION.
    METHODS eordersset_delete_entity REDEFINITION.
  PRIVATE SECTION.
    METHODS generic_filter IMPORTING iv_entity_name           TYPE string
                                     it_filter_select_options TYPE /iwbep/t_mgw_select_option
                           CHANGING  ct_entityset             TYPE standard table
                           RAISING   /iwbep/cx_mgw_tech_exception.
ENDCLASS.



CLASS zcl_zcdx_orders_dpc_ext IMPLEMENTATION.


  METHOD eitemsset_delete_entity.

    DATA eitemsset_get_entity TYPE zcl_zcdx_orders_mpc=>ts_items.

    DATA(lv_source_entity_set_name) = io_tech_request_context->get_entity_set_name( ).
    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = eitemsset_get_entity ).


    DELETE FROM zcdx_item_00 WHERE order_nr    = @eitemsset_get_entity-order_nr
                               AND order_posnr = @eitemsset_get_entity-order_posnr.
    IF sy-subrc <> 0.

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          http_status_code = 204
          entity_type      = io_tech_request_context->get_entity_type_name( ).

    ENDIF.
  ENDMETHOD.


  METHOD eitemsset_get_entityset.
    super->eitemsset_get_entityset(
    EXPORTING
      iv_entity_name               = iv_entity_name
      iv_entity_set_name           = iv_entity_set_name
      iv_source_name               = iv_source_name
      it_filter_select_options     = it_filter_select_options    " Table of select options
      is_paging                    = is_paging    " Paging structure
      it_key_tab                   = it_key_tab    " Table for name value pairs
      it_navigation_path           = it_navigation_path    " Table of navigation paths
      it_order                     = it_order    " The sorting order
      iv_filter_string             = iv_filter_string    " Table for name value pairs
      iv_search_string             = iv_search_string
      io_tech_request_context      = io_tech_request_context
    IMPORTING
      et_entityset                 = et_entityset    " Returning data
      es_response_context          = es_response_context
  ).


    IF io_tech_request_context->has_inlinecount( ) = abap_true.
      es_response_context-inlinecount = lines( et_entityset ).
    ENDIF.


    IF it_order[] IS NOT INITIAL.

*      /iwbep/cl_mgw_data_util=>orderby( EXPORTING it_order = it_order
*                                        CHANGING  ct_data  = et_entityset ).

      /iwbep/cl_mgw_data_util=>orderby( EXPORTING it_order = CORRESPONDING #( io_tech_request_context->get_orderby( ) )
                                        CHANGING  ct_data  = et_entityset ).

    ENDIF.

* Works fine if abap fieldname == entity fieldname
* otherwise see me->generic_filter
    /iwbep/cl_mgw_data_util=>filtering( EXPORTING it_select_options = it_filter_select_options
                                        CHANGING  ct_data           = et_entityset ).

*    LOOP AT it_filter_select_options ASSIGNING FIELD-SYMBOL(<filter_select_option>).
*      IF <filter_select_option>-property = 'OrderNr'.
*        DELETE et_entityset WHERE order_nr NOT IN <filter_select_option>-select_options.
*      ENDIF.
*    ENDLOOP.

  ENDMETHOD.


  METHOD eordersset_delete_entity.

    DATA eordersset_get_entity TYPE zcl_zcdx_orders_mpc=>ts_orders.
    DATA eitemsset_get_entity TYPE zcl_zcdx_orders_mpc=>ts_items.

    DATA(lv_source_entity_set_name) = io_tech_request_context->get_entity_set_name( ).
* io_tech_request_context->get_converted_source_keys( IMPORTING es_key_values = data(ls_converted_source_keys) ).

    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = eordersset_get_entity ).


    DELETE FROM zcdx_order_00 WHERE order_nr = @eordersset_get_entity-order_nr.
    IF sy-subrc <> 0.
*The server successfully processed the request, but is not returning any content
*204 No Content
*
*Resource does not exist
*404 Not Found
*
*Resource already deleted
*410 Gone
*
*Users does not have permission
*403 Forbidden
*
*Method Not Allowed
*405 Method Not Allowed
*
*Conflict (User can resolve the conflict and delete)
*409 Conflict

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
*         textid           = textid
*         previous         = previous
*         message_container      = message_container
          http_status_code = 204
*         http_header_parameters = http_header_parameters
*         sap_note_id      = sap_note_id
          entity_type      = io_tech_request_context->get_entity_type_name( )
*         message          = message
*         message_unlimited      = message_unlimited
*         filter_param     = filter_param
*         operation_no     = operation_no
        .
    ENDIF.
  ENDMETHOD.


  METHOD eordersset_get_entityset.
    super->eordersset_get_entityset(
      EXPORTING
        iv_entity_name               = iv_entity_name
        iv_entity_set_name           = iv_entity_set_name
        iv_source_name               = iv_source_name
        it_filter_select_options     = it_filter_select_options    " Table of select options
        is_paging                    = is_paging    " Paging structure
        it_key_tab                   = it_key_tab    " Table for name value pairs
        it_navigation_path           = it_navigation_path    " Table of navigation paths
        it_order                     = it_order    " The sorting order
        iv_filter_string             = iv_filter_string    " Table for name value pairs
        iv_search_string             = iv_search_string
        io_tech_request_context      = io_tech_request_context
      IMPORTING
        et_entityset                 = et_entityset    " Returning data
        es_response_context          = es_response_context
    ).



    IF io_tech_request_context->has_inlinecount( ) = abap_true.

      es_response_context-inlinecount = lines( et_entityset ).

    ENDIF.

    IF it_order IS NOT INITIAL.

      /iwbep/cl_mgw_data_util=>orderby( EXPORTING it_order = CORRESPONDING #( io_tech_request_context->get_orderby( ) )
                                        CHANGING  ct_data  = et_entityset ).

    ENDIF.

    IF it_filter_select_options IS NOT INITIAL.

      me->generic_filter( EXPORTING iv_entity_name           = iv_entity_name
                                    it_filter_select_options = it_filter_select_options
                          CHANGING  ct_entityset             = et_entityset ).

    ENDIF.

  ENDMETHOD.

  METHOD generic_filter.

    DATA: facade TYPE REF TO /iwbep/cl_mgw_dp_facade.
    facade ?= /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).

    DATA(entity_type) = facade->/iwbep/if_mgw_dp_int_facade~get_model( )->get_entity_type( CONV #( iv_entity_name ) ).
    DATA(properties) = entity_type->get_properties( ).

    DATA(lt_filter_select_options) = it_filter_select_options.
    LOOP AT lt_filter_select_options ASSIGNING FIELD-SYMBOL(<filter_select_option>).
      <filter_select_option>-property = to_upper( <filter_select_option>-property ).
      IF NOT line_exists( properties[ technical_name = <filter_select_option>-property ] ).
        LOOP AT properties ASSIGNING FIELD-SYMBOL(<property>).
          IF to_upper( <property>-property->get_name( ) ) = <filter_select_option>-property.
            <filter_select_option>-property = to_upper( <property>-property->get_abap_name( ) ).
            EXIT. " LOOP.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.

    /iwbep/cl_mgw_data_util=>filtering( EXPORTING it_select_options = lt_filter_select_options
                                        CHANGING  ct_data           = ct_entityset ).

    LOOP AT it_filter_select_options ASSIGNING  <filter_select_option>.
*        IF <filter_select_option>-property = 'OrderNr'.
*          DELETE et_entityset WHERE order_nr NOT IN <filter_select_option>-select_options.
*        ENDIF.

*        IF <filter_select_option>-property = 'Customer'.
*          DELETE et_entityset WHERE customer NOT IN <filter_select_option>-select_options.
*        ENDIF.

*        IF <filter_select_option>-property = 'OrderDate'.
*          DELETE et_entityset WHERE order_date NOT IN <filter_select_option>-select_options.
*        ENDIF.

*        IF <filter_select_option>-property = 'TotalPrice'.
*          DELETE et_entityset WHERE total_price NOT IN <filter_select_option>-select_options.
*        ENDIF.


    ENDLOOP.

  ENDMETHOD.


ENDCLASS.
