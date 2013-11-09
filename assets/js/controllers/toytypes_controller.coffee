@ToytypesController = ($scope, $routeParams, $location, Toytypes, ToytypesArchive) ->
  $scope.toytypes = ToytypesArchive.getToytypes()

  $scope.mode_set = [
    {name:'小颗粒', value:'小颗粒'},
    {name:'大颗粒', value:'大颗粒'},
  ]

  $scope.create = ->
    toytype= new Toytypes
      sno: @toytype.sno
      cname: @toytype.cname
      ename: @toytype.ename
      age: @toytype.age
      price: @toytype.price
      office_price: @toytype.office_price
      buying_price: @toytype.buying_price
      release_year: @toytype.release_year
      pieces: @toytype.pieces
      doll_num: @toytype.doll_num
      volume: @toytype.volume
      weight: @toytype.weight
      mode: @toytype.mode
      desc: @toytype.desc

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
