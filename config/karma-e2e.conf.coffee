module.exports = (config) ->
  config.set
    basePath: ".."
    files: ["test/e2e/**/*.js", "test/e2e/**/*.coffee"]
    autoWatch: false
    browsers: ["Chrome"]
    frameworks: ["ng-scenario"]
    singleRun: true
    proxies:
      "/": "http://localhost:4000/"

    urlRoot: "/__karma/"
    plugins: ["karma-junit-reporter",
    "karma-chrome-launcher",
    "karma-firefox-launcher",
    "karma-jasmine",
    "karma-coffee-preprocessor",
    "karma-ng-scenario"]
    
    junitReporter:
      outputFile: "test_out/e2e.xml"
      suite: "e2e"

