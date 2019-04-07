App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('someone is typing')
    $('#messages').append data['message']
  
  hideBubble: ->
    $('#messages #is-typing').hide()
    
  speak: (message) ->
    @perform 'speak', message: message
    
  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    # $('#messages #is-typing').show()
    # setTimeout(App.room.hideBubble, 2000)
    
    if event.keyCode is 13
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()
