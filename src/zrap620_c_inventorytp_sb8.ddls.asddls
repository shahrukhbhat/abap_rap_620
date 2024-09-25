@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRAP620_R_INVENTORYTP_SB8'
define root view entity ZRAP620_C_INVENTORYTP_SB8
  provider contract transactional_query
  as projection on ZRAP620_R_INVENTORYTP_SB8
{
  key UUID,
      InventoryID,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZRAP620_CE_PRODUCTS_SB8', element: 'Product'  } , useForValidation: true }]  
      ProductID,
      Quantity,
      @Consumption.valueHelpDefinition: [ {
          entity: {
            name: 'I_UnitOfMeasure',
            element: 'UnitOfMeasure'
          }
          } ]
      QuantityUnit,
      Price,
      @Consumption.valueHelpDefinition: [ {
      entity: {
       name: 'I_Currency',
       element: 'Currency'
      }
      } ]
      CurrencyCode,
      Description,
      OverallStatus,
      LastChangedAt

}
