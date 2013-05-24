jQuery ->

  class window.Item extends Backbone.Model
    defaults:
      part1: 'Hello'
      part2: 'Backbone'

  class window.List extends Backbone.Collection
    localStorage: new Backbone.LocalStorage("ListStorage")
    model: Item

  class window.Quote extends Backbone.Model

  class window.QuoteList extends Backbone.Collection
    model: Quote
    url: "lib/quotes/quotes.json"
    initialize: ->
      @fetch()


  class window.ItemView extends Backbone.View
    tagName: 'li'
    initialize: ->
      _.bindAll @


      @model.bind 'change', @render
      @model.bind 'remove', @unrender

    render: =>
      console.log list_view.collection.localStorage.find(@model)
      if list_view.collection.localStorage.find(@model) != null
        #replaces the content of $el with the string
        $(@el).html """
          <span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>
          <span class="swap">swap</span>
          <span class="delete">delete</span>
        """
      else
        $(@el).html """
          <span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>
          <span class="swap">swap</span>
          <span class="save">save</span>
          <span class="delete">delete</span>
        """
      @

    unrender: =>
      $(@el).remove()

    swap: ->
      @model.set
        part1: @model.get 'part2'
        part2: @model.get 'part1'


    remove: ->
      if list_view.collection.localStorage.find(@model) != null
        list_view.collection.localStorage.destroy(@model)
        @unrender()

      else
        @model.destroy() # this triggers change

    save: ->
      @model.set
        part2:"#{@model.get 'part2'} saved in #{new Date()}"
      @model.save()

    events:
      'click .swap': 'swap'
      'click .delete': 'remove'
      'click .save': 'save'



  # main application view
  class window.ListView extends Backbone.View
    el: $ 'body'
    initialize: ->

      _.bindAll @ # UNDERSCORE.JS:.bindAll @ binds all methods to this object
      @collection = new List
      @quotes = new QuoteList

      @collection.bind 'add', @appendItem # BACKBONE.JS:.BIND associates an event with a function. That's all.
                                          # whenever the 'add' event is triggered, the appendItem will be called.
                                          # on newer backbones, '.bind' has changed to '.on' !!
      @counter = 0



      @render()
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'

    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item

    appendItem: (item) ->
      item_view = new ItemView model: item
      $('ul').append item_view.render().el



      if @counter > 0 and @counter < 7
        $('#quotes').text(@quotes.at(@counter).get('text'))


    events: 'click button': 'addItem'



  window.list_view = new ListView
  list_view.collection.fetch() # fetches all items saved on localStorage
  list_view.collection.reset(list_view.collection.toJSON()) #resets the collection with the fetched items

