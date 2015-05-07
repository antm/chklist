jQuery ->
  console.log('ready')
  
  $('#tasks').sortable(
    axis: 'y',
    update: ->
      alert('sorted')
  )
