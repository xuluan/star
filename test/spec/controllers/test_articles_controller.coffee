"use strict"
describe "Controller: ArticlesController", ->
  
  # load the controller's module
  beforeEach module("myApp")
  ArticlesController = undefined
  scope = undefined
  $httpBackend = undefined
  
  # Initialize the controller and a mock scope
  beforeEach inject((_$httpBackend_, $controller, $rootScope) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET("/articles").respond [
      title: "a"
      content: "b"
    ,
      title: "c"
      content: "d"
    ]
    scope = $rootScope.$new()
    ArticlesController = $controller("ArticlesController",
      $scope: scope
    )
  )
  it "should attach a list of awesomeThings to the scope", ->
    expect(scope.articles.length).toBe 0
    $httpBackend.flush()
    expect(scope.articles.length).toBe 2
    expect(scope.awesomeThings).toBeUndefined()
    


