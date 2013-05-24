$ ->
      class window.Item extends Backbone.Model
          defaults:
              part1: 'Hello'
              part2: 'Backbone'

      class window.List extends Backbone.Collection
          model: Item

      class window.Quote extends Backbone.Model
          defaults:
            quote: "for the docs?"

      class window.QuoteList extends Backbone.Collection
          model: Quote
          url: "lib/quotes.json"

      class window.ListView extends Backbone.View

          el: $ 'body' #select body as the DOM element to work with

          initialize: ->  # the constructor
              _.bindAll @

              @collection = new List
              @collection.bind 'add', @appendItem
              @collection.bind 'remove', @removeItem
              console.log @removeItem
              @quotes = new QuoteList
              @quotes.fetch()
              @counter = 0
              @counter.bind 'appendItem',

              @render() # here we're calling the render method in order to render the view

          render: ->
              $(@el).append '<button id="addButton">Add List Item</button>' # puts a button on the body
              $(@el).append '<button id="removeButton">Remove List Item</button>' # puts a button on the body
              $(@el).append '<ul><li>Hello, Backbone! </li></ul>' # puts Hello Backbone on the body

          addItem: -> # will be called when the user clicks on the button - this is defined on the 'events'
              console.log @quotes.at(@counter).get('quote')
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
              console.log @counter
              #$('#quotes').text(@quotes.at(@counter).get('quote'))
          removeItem: ->
              $('li:last-child').remove()
              console.log($('li:last-child'))
          events:
              'click button#addButton': 'addItem' # when the button (any button) is clicked, addItem() will be called
              'click button#removeButton': 'deleteItem'

      window.list_view = new ListView # instantiating the view by creating a New ListView
