
window.app.factory  "Toytypes", ($resource) ->
  $resource "/toytypes/:toytypeId",
    toytypeId: '@_id'
  ,
    update:
      method: "PUT"
      
window.app.factory  "ToytypesArchive", (Toytypes) ->
  toytypesArchive = null
  factory =
    getToytypes : ->
      toytypesArchive ?= Toytypes.query()
    ,
    reset : ->
      toytypesArchive = null
   
 