class ZCL_CDX_ADT_WS_DEMO_CLASS definition
  public
  final
  create public .

public section.

  types TY_I_M_A_PRIVATE_TYPE type CHAR1 .
  types TY_I_M_A_PROTECTED_TYPE type CHAR1 .
  types TY_I_M_A_PUBLIC_TYPE type CHAR1 .

  class-data I_M_A_PUBLIC_STAT_ATTRIBUTE type C .
  data I_M_A_PUBLIC_INST_ATTRIBUTE type C .

  class-methods I_M_A_PUB_STAT_METHOD
    importing
      !I_IMPORTING type CHAR1
    exporting
      !E_EXPORTING type CHAR1
    changing
      !C_CHANGING type CHAR1 .
  methods I_M_A_PUBLIC_INST_METHOD .
protected section.

  class-data I_M_A_PROTECTED_STAT_ATTRIBUTE type C .
  data I_M_A_PROTECTED_INST_ATTRIBUTE type C .

  class-methods I_M_A_PROTECTED_STAT_METHOD .
  methods I_M_A_PROTECTED_INST_METHOD .
private section.

  class-data I_M_A_PRIVATE_STAT_ATTRIBUTE type C .
  data I_M_A_PRIVATE_INST_ATTRIBUTE type C .

  class-methods I_M_A_PRIVATE_STAT_METHOD .
  methods I_M_A_PRIVATE_INST_METHOD .
ENDCLASS.



CLASS ZCL_CDX_ADT_WS_DEMO_CLASS IMPLEMENTATION.


  METHOD i_m_a_private_inst_method.
  ENDMETHOD.


  METHOD i_m_a_private_stat_method.
  ENDMETHOD.


  METHOD i_m_a_protected_inst_method.
  ENDMETHOD.


  METHOD i_m_a_protected_stat_method.
  ENDMETHOD.


  METHOD i_m_a_public_inst_method.
  ENDMETHOD.


  METHOD i_m_a_pub_stat_method.
  ENDMETHOD.
ENDCLASS.
