jQuery ->
  $('#tasks').sortable(
    axis: 'y',
    update: ->
      console.log('sorted')
  )
