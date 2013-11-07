@ArticlesController = ($scope, $routeParams, $location, Articles, ArticlesArchive) ->
  $scope.articles = ArticlesArchive.getArticles()

  $scope.create = ->
    article= new Articles
      title: @article.title
      content: @article.content

    article.$save (response) ->
      console.log response
      ArticlesArchive.reset()
      $location.path("articles/")
    
  $scope.findOne = ->
    if $scope.articles[$routeParams.articleId]
      $scope.article = $scope.articles[$routeParams.articleId]

  $scope.save = ->
    if $scope.article._id
      $scope.update()
    else
      $scope.create()

  $scope.update = ->
    article = $scope.article
    article.$update ->
      ArticlesArchive.reset()
      $location.path 'articles/'


  $scope.remove = (idx)->
    return unless confirm("Do you want to remove it?")
    article = $scope.articles[idx]
    article.$delete (response) ->
      console.log response
      ArticlesArchive.reset()
      $location.path("articles/")
