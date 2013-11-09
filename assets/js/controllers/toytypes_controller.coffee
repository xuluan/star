@ToytypesController = ($scope, $routeParams, $location, Toytypes, ToytypesArchive) ->
  $scope.toytypes = ToytypesArchive.getToytypes()

  $scope.status_set = [
    {name:'正常', value:'正常'},
    {name:'暂停', value:'暂停'},
  ]

  $scope.create = ->
    toytype= new Toytypes
      title: @toytype.title
      addr: @toytype.addr
      tel: @toytype.tel
      desc: @toytype.desc
      status: @toytype.status

    toytype.$save (response) ->
      console.log response
      ToytypesArchive.reset()
      $location.path("toytypes/")
    
  $scope.findOne = ->
    if $scope.toytypes[$routeParams.toytypeId]
      $scope.toytype = $scope.toytypes[$routeParams.toytypeId]

  $scope.save = ->
    if $scope.toytype._id
      $scope.update()
    else
      $scope.create()

  $scope.update = ->
    toytype = $scope.toytype
    toytype.$update ->
      ToytypesArchive.reset()
      $location.path 'toytypes/'


  $scope.remove = (idx)->
    return unless confirm("Do you want to remove it?")
    toytype = $scope.toytypes[idx]
    toytype.$delete (response) ->
      console.log response
      ToytypesArchive.reset()
      $location.path("toytypes/")
