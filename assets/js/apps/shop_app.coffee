"use strict"

myApp = angular.module 'myApp', ['ngResource']
window.app = myApp
myApp.config ($routeProvider, $locationProvider) ->
      
  $routeProvider.when "/shops/new",
    templateUrl: "/partials/shops/edit.html"
    controller: ShopsController
    
  $routeProvider.when "/shops",
    templateUrl: "/partials/shops/all.html"
    controller: ShopsController
    
  $routeProvider.when "/shops/:shopId/edit",
    templateUrl: "/partials/shops/edit.html"
    controller: ShopsController
 
  $routeProvider.when "/shops/:shopId/",
    templateUrl: "/partials/shops/show.html"
    controller: ShopsController

            
  $routeProvider.otherwise redirectTo: "/shops"
