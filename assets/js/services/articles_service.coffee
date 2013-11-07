
window.app.factory  "Articles", ($resource) ->
  $resource "/articles/:articleId",
    articleId: '@_id'
  ,
    update:
      method: "PUT"
      
window.app.factory  "ArticlesArchive", (Articles) ->
  articlesArchive = null
  factory =
    getArticles : ->
      articlesArchive ?= Articles.query()
    ,
    reset : ->
      articlesArchive = null
   
 