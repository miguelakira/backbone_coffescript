jQuery ->

  class ListView extends Backbone.View

    el: $ 'body'

    initialize: ->
      _.bindAll @
      @counter = 0
      @render()

    render: ->
      console.log @counter
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'

    addItem: ->
      @counter++
      $('ul').append "<li>Hello, Backbone #{@counter}!</li>"

    showCounter: ->
      @counter++
      console.log @counter

    events: 'click button': 'addCounter'

  list_view = new ListView
