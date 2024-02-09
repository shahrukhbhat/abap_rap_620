CLASS lhc_inventory DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Inventory
        RESULT result,
      CalculateInventoryID FOR DETERMINE ON SAVE
        IMPORTING keys FOR Inventory~CalculateInventoryID.
ENDCLASS.

CLASS lhc_inventory IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD CalculateInventoryID.

    "Ensure idempotence
    READ ENTITIES OF zrap620_r_inventorytp_SB8 IN LOCAL MODE
      ENTITY Inventory
        FIELDS ( InventoryID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(inventories).

    DELETE inventories WHERE InventoryID IS NOT INITIAL.
    CHECK inventories IS NOT INITIAL.

    "Get max travelID
    SELECT SINGLE FROM zrap620_invenSB8 FIELDS MAX( inventory_id ) INTO @DATA(max_inventory).

    "update involved instances
    MODIFY ENTITIES OF zrap620_r_inventorytp_SB8 IN LOCAL MODE
      ENTITY Inventory
        UPDATE FIELDS ( InventoryID )
        WITH VALUE #( FOR inventory IN inventories INDEX INTO i (
                           %tky      = inventory-%tky
                           inventoryID  = max_inventory + i ) )
    REPORTED DATA(lt_reported).

    "fill reported
    reported = CORRESPONDING #( DEEP lt_reported ).


  ENDMETHOD.


ENDCLASS.
