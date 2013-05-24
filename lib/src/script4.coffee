jQuery ->
  # basic Item; Item.part2 will be modified later.
  class window.Item extends Backbone.Model
    defaults:
      part1: 'Hello'
      part2: 'Backbone'

  # this is a collection of items. A collection is an ordered set of models.
  class window.List extends Backbone.Collection
    model: Item

  # this is the view for the Item, in order to separate it from the main application view.
  class window.ItemView extends Backbone.View
    tagName: 'li' #  will generate a li div in our @el.

    initialize: ->
      _.bindAll @ #  binds all methods to this object, so when they're called will be always on this object's context.
    render: ->
      # model is set when it's instantiated on List
      console.log $(@el)
      $(@el).html "<span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>" #replaces the content of $el with the string
      console.log $(@el)
      @ # returns 'this' to be able to chain methods

  class window.ListView extends Backbone.View
    el: $ 'body'
    initialize: ->

      _.bindAll @ # UNDERSCORE.JS:.bindAll @ binds all methods to this object
      @collection = new List
      @collection.on 'add', @appendItem # BACKBONE.JS:.BIND associates an event with a function. That's all.
                                          # whenever the 'add' event is triggered, the appendItem will be called.
                                          # on newer backbones, '.bind' has changed to '.on' !!
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


  list_view = new ListView
