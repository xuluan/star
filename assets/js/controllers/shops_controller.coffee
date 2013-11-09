@ShopsController = ($scope, $routeParams, $location, Shops, ShopsArchive) ->
  $scope.shops = ShopsArchive.getShops()

  $scope.status_set = [
    {name:'正常', value:'正常'},
    {name:'暂停', value:'暂停'},
  ]

  $scope.create = ->
    shop= new Shops
      title: @shop.title
      addr: @shop.addr
      tel: @shop.tel
      desc: @shop.desc
      status: @shop.status

    shop.$save (response) ->
      console.log response
      ShopsArchive.reset()
      $location.path("shops/")
    
  $scope.findOne = ->
    if $scope.shops[$routeParams.shopId]
      $scope.shop = $scope.shops[$routeParams.shopId]

  $scope.save = ->
    if $scope.shop._id
      $scope.update()
    else
      $scope.create()

  $scope.update = ->
    shop = $scope.shop
    shop.$update ->
      ShopsArchive.reset()
      $location.path 'shops/'


  $scope.remove = (idx)->
    return unless confirm("Do you want to remove it?")
    shop = $scope.shops[idx]
    shop.$delete (response) ->
      console.log response
      ShopsArchive.reset()
      $location.path("shops/")
