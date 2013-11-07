"use strict"

myApp = angular.module 'myApp', ['ngResource']
window.app = myApp
myApp.config ($routeProvider, $locationProvider) ->
      
  $routeProvider.when "/articles/new",
    templateUrl: "/partials/articles/edit.html"
    controller: ArticlesController
    
  $routeProvider.when "/articles",
    templateUrl: "/partials/articles/all.html"
    controller: ArticlesController
    
  $routeProvider.when "/articles/:articleId/edit",
    templateUrl: "/partials/articles/edit.html"
    controller: ArticlesController
 
  $routeProvider.when "/articles/:articleId/",
    templateUrl: "/partials/articles/show.html"
    controller: ArticlesController

            
  $routeProvider.otherwise redirectTo: "/articles"
