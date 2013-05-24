jQuery ->

  # single model. Backbone.js models can represent only one instance of an object
  class window.Item extends Backbone.Model
    defaults:
      part1: 'Hello'
      part2: 'Backbone'

  # collection of Items. A collection is an ordered set of models.
  class window.List extends Backbone.Collection
    model: Item

  # main application view
  class window.ListView extends Backbone.View
    el: $ 'body' # selects the 'body' element
    initialize: ->

      _.bindAll @ # binds all methods to this object
      @collection = new List
      @collection.bind 'add', @appendItem #binds the add event to the appendItem function
      @counter = 0
      @render() # renders the view

    render: -> # appends a button and ul divs to the 'body' element
      console.log $(@el)
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'


    # called when the click event is triggered
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@collection.counter}"
      @collection.add item # adds the new modified item to the collection and triggers the appendItem function

    appendItem: (item) ->
      $('ul').append "<li>#{item.get 'part1'} #{item.get 'part2'}!</li>" # appends the string to the ul divs

    events: 'click button': 'addItem' # calls the addItem function whenever a button is clicked


  list_view = new ListView # instantiates our view.
