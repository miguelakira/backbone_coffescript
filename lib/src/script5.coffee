jQuery ->
  # basic Item Item.part2 will be modified later.
  class window.Item extends Backbone.Model
    defaults:
      part1: 'Hello'
      part2: 'Backbone'

  # this is a collection of items. A collection is an ordered set of models.
  class window.List extends Backbone.Collection
    model: Item

  class ItemView extends Backbone.View
    tagName: 'li'
    initialize: ->
      _.bindAll @

      @model.bind 'change', @render
      @model.bind 'remove', @unrender

    render: =>
      $(@el).html """
        <span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>
        <span class="swap">swap</span>
        <span class="delete">delete</span>
      """
      @

    unrender: =>
      $(@el).remove()

    swap: ->
      @model.set
        part1: @model.get 'part2'
        part2: @model.get 'part1'


    remove: -> @model.destroy()


    events:
      'click .swap': 'swap'
      'click .delete': 'remove'



  # main application view
  class window.ListView extends Backbone.View
    el: $ 'body'
    initialize: ->

      _.bindAll @ # UNDERSCORE.JS:.bindAll @ binds all methods to this object
      @collection = new List
      @collection.bind 'add', @appendItem # BACKBONE.JS:.BIND associates an event with a function. That's all.
                                          # whenever the 'add' event is triggered, the appendItem will be called.
      @counter = 0
      @render() # calls the render method of this view
    render: ->
      $(@el).append '<button>Add List Item</button>' # renders the button and the ul divs
      $(@el).append '<ul></ul>'

    # this function is called when the click event is triggered
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item #add event adds the modified item to the collection and triggers the appendItem.

    appendItem: (item) ->
      item_view = new ItemView model: item # instantiates a new item_view with model: item
      # console.log item_view.render()
      # console.log item_view.render().el
      # console.log $('ul')
      $('ul').append item_view.render().el # append the result of item_view.render().el to the $('ul').
                                           # if $('ul').html were used, it would replace the content instead of appending it.

    events: 'click button': 'addItem' # whenever a button is clicked, the addItem function is called.
                                      # if a specific button were to be trigerred, the use of classes or ids are necessary
                                      # like so: 'click button#addNewItem' and <button id="addNewItem">

  # since there's no persistence, we have to modify the Backbone.sync
  Backbone.sync = (method, model, success, error) ->
    success()
  list_view = new ListView
