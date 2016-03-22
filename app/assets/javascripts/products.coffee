#$(document).ready ->
#  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1'
#
#  $.ajax
#    url: "#{baseUrl}/products"
#    type: 'GET'
#    success: (data) ->
#      for product in data.products
#        $.ajax
#          url: '/product_card'
#          type: 'GET'
#          data:
#            product: product
#          success: (data) ->
#            $('#products').append data
#          error: (data) ->
#            console.log data 
#    error: (data) ->
#      console.log data
#      
#  $.ajax
#    url: "#{baseUrl}/products/#{[id]}"
#    type: 'GET'
#    success: (data) ->
#      for product in data.products
#        $.ajax
#          url: '/product_card'
#          type: 'POST'
#          data:
#            product: product
#          dataType: 'json'
#          success: (data) ->
#            if data.status
#              $('#product').val ''
#          error: ->
#            $('#msg').html '<div class="faile">Error! Please try again.</div>'
#    error: (data) ->
#      console.log data


  $(document).ready ->
    baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/products'
    if location.pathname == '/'
      $.ajax
        url: baseUrl
        type: 'GET'
        dataType: 'JSON'
        success: (data) ->
          tbody = $('#products')
          data.products.forEach (product) ->
            name = product.name
            price = product.base_price
            row = '<tr><td>' + name + '</td>'
            row += '<td>' + price + '</td><'
            row += '<td><button data-id="' + product.id + '"class="show btn btn-primary blue">Show</button></td></tr>'
            tbody.append row
            
          
        error: (error) ->
          console.log error
          alert 'Nigga, wrong database URL:'
          
      $(document).on 'click', '.show', ->
        id = @dataset.id
        location.href = '/products/' + id
        
    re = /\/products\/\d+/
    if location.pathname.match(re)
      panel = $('#panel')
      id = panel.data('id')
      $.ajax
        url: baseUrl + '/' + id
        type: 'GET'
        dataType: 'JSON'
        success: (data) ->
          product = data.product
          $('#heading').html product.name
          list = $('#products')
          price = "<li>Price: '#{product.base_price}'</li><br />"
          remove = '<li><button class="btn btn-danger blue" id="remove">Delete</button></li>'
          list.append price
          list.append remove
          
    $(document).on 'click', '#remove', ->
      $.ajax
        url: baseUrl + '/' + id
        type: 'DELETE'
        success: ->
          location.href = '/'
          
      
    $('#add_product_button').click (e) ->
      e.preventDefault()
      $('html, body').animate { scrollTop: $(document).height() }, 'slow'
      
    $('#add_product_form').submit (e) ->
      e.preventDefault()
      $.ajax
        url: baseUrl
        type: 'POST'
        dataType: 'JSON'
        data: $(this).serializeArray()
        success: (data) ->
          window.location.href = '/'
          
        error: (data) ->
          console.log data
          
      false
    


