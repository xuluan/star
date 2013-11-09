"use strict"

myApp = angular.module 'myApp', ['ngResource']
window.app = myApp
myApp.config ($routeProvider, $locationProvider) ->
      
  $routeProvider.when "/toytypes/new",
    templateUrl: "/partials/toytypes/edit.html"
    controller: ToytypesController
    
  $routeProvider.when "/toytypes",
    templateUrl: "/partials/toytypes/all.html"
    controller: ToytypesController
    
  $routeProvider.when "/toytypes/:toytypeId/edit",
    templateUrl: "/partials/toytypes/edit.html"
    controller: ToytypesController
 
  $routeProvider.when "/toytypes/:toytypeId/",
    templateUrl: "/partials/toytypes/show.html"
    controller: ToytypesController

            
  $routeProvider.otherwise redirectTo: "/toytypes"
