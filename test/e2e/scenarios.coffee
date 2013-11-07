"use strict"

# http://docs.angularjs.org/guide/dev_guide.e2e-testing
describe "my app", ->
  beforeEach ->
    browser().navigateTo "/"

  it "should automatically redirect articles", ->
    expect(browser().location().path()).toBe "/articles"
    expect(element("h1").html()).toContain "Nodejs Seed"

  it "should enter articles new", ->
    
    browser().navigateTo "/#/articles/new"
    expect(browser().window().href()).toBe "http://localhost:9876/#/articles/new"
    expect(element("label").html()).toContain "Title"
    expect(element("label").count()).toBe 2

  it "should wait", ->
    expect(browser().window().href()).toBe "http://localhost:9876/#/articles"


