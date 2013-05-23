$ ->
    class Item extends Backbone.Model
        defaults:
            part1: 'Hello'
            part2: 'Backbone'

    class List extends Backbone.Collection
        model: Item

    class ListView extends Backbone.View

        el: $ 'body' #select body as the DOM element to work with

        initialize: ->  # the constructor
            _.bindAll @

            @collection = new List
            @collection.bind 'add', @appendItem
            @collection.bind 'remove', @removeItem

            @counter = 0
            @render() # here we're calling the render method in order to render the view

        render: ->
            $(@el).append '<button id="addButton">Add List Item</button>' # puts a button on the body
            $(@el).append '<button id="removeButton">Remove List Item</button>' # puts a button on the body
            $(@el).append '<ul><li>Hello, Backbone! </li></ul>' # puts Hello Backbone on the body

        addItem: -> # will be called when the user clicks on the button - this is defined on the 'events'
            @counter++

            item = new Item
            item.set part2: "#{item.get 'part2'} #{@counter}"

            @collection.add item

        deleteItem: ->
            @counter--
            item = @collection.last()

            @collection.remove item

        appendItem: (item) ->
            $('ul').append "<li>#{item.get 'part1'} #{item.get 'part2'}</li>"

        removeItem: ->
            $('li:last-child').remove()
            console.log($('li:last-child'))
        events:
            'click button#addButton': 'addItem' # when the button (any button) is clicked, addItem() will be called
            'click button#removeButton': 'deleteItem'

    list_view = new ListView # instantiating the view by creating a New ListView

