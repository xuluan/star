
window.app.factory  "Shops", ($resource) ->
  $resource "/shops/:shopId",
    shopId: '@_id'
  ,
    update:
      method: "PUT"
      
window.app.factory  "ShopsArchive", (Shops) ->
  shopsArchive = null
  factory =
    getShops : ->
      shopsArchive ?= Shops.query()
    ,
    reset : ->
      shopsArchive = null
   
 