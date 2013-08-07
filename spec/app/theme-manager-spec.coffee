$ = require 'jquery'

Theme = require 'theme'
ThemeManager = require 'theme-manager'

describe "ThemeManager", ->
  describe "when the core.themes config value changes", ->
    it "add/removes stylesheets to reflect the new config value", ->
      themeManager = new ThemeManager()
      spyOn(themeManager, 'getUserStylesheetPath').andCallFake -> null
      themeManager.load()
      config.set('core.themes', [])
      expect($('style.userTheme').length).toBe 0

      config.set('core.themes', ['atom-dark-syntax'])
      expect($('style.userTheme').length).toBe 1
      expect($('style.userTheme:eq(0)').attr('id')).toBe Theme.resolve('atom-dark-syntax')

      config.set('core.themes', ['atom-light-syntax', 'atom-dark-syntax'])
      expect($('style.userTheme').length).toBe 2
      expect($('style.userTheme:eq(0)').attr('id')).toBe Theme.resolve('atom-light-syntax')
      expect($('style.userTheme:eq(1)').attr('id')).toBe Theme.resolve('atom-dark-syntax')

      config.set('core.themes', [])
      expect($('style.userTheme').length).toBe 0