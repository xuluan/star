


coffeelint_files = ["./*.coffee",
        "./assets/**/*.coffee",
        "./app/**/*.coffee",
        "./config/**/*.coffee",
        "./test/**/*.coffee"]
        
module.exports = (grunt) ->
  require("load-grunt-tasks") grunt
    
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    watch:
      coffeelint:
        files: coffeelint_files
        
        tasks: ['coffeelint:app']
        options:
          spawn: true
        
    coffeelint:
      options:
        no_trailing_whitespace:
          level: "warn"

        max_line_length:
          level: "error"
          value: "100"

      app:coffeelint_files

    nodemon:
      dev:
        options:
          file: "server.coffee"
          ignoredFiles: ["README.md", "node_modules/**", "test/**"],
          watchedExtensions: ["js", "coffee", "css", "ejs", "json", "html"]
          watchedFolders: ["."]
          delayTime: 0
          legacyWatch: true
          env:
            PORT: "3000"

          cwd: __dirname
      test:
        options:
          file: "server.coffee"
          ignoredFiles: ["README.md", "node_modules/**", "test/**"],
          watchedExtensions: ["js", "coffee", "css", "ejs", "json", "html"]
          watchedFolders: ["."]
          delayTime: 0
          legacyWatch: true
          cwd: __dirname
          env:
            NODE_ENV : 'test'            

    karma:
      unit:
        configFile: "config/karma.conf.coffee"
        singleRun: true
      e2e:
        configFile: "config/karma-e2e.conf.coffee"
        singleRun: true
        
    concurrent:
      options:
        logConcurrentOutput: true
      server: ["watch:coffeelint", "nodemon:dev"]
      test: ["nodemon:test", "karma:e2e"]
  
  grunt.registerTask 'drop', 'drop test db', (env)->
    env= 'test' unless env
    config = require('./config/config')[env]
    unless config
      console.log env + " isn't exist."
      return
    
    
    mongoose = require 'mongoose'
    mongoose.connect config.db
    done = this.async()
    
    mongoose.connection.on 'open', ->
      mongoose.connection.db.dropDatabase (err) ->
        if err
          console.log err
        else
          console.log "dropped"
        mongoose.connection.close(done)

      
  grunt.registerTask 'e2e', ['drop:test', ]
  
  grunt.registerTask 'server', ['concurrent:server']
  grunt.registerTask 'test', ['karma:unit', 'drop:test', 'concurrent:test']
  