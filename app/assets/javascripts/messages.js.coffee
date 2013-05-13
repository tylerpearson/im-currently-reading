ready = () ->
    console.log "loaded"


$(document).on 'click', '.toggle-bottom', () ->

    $bottomArea      = $('.bottom-area')
    $toggleText      = $('.toggle-text')
    $toggleIndicator = $('.toggle-indicator')

    $bottomArea.toggleClass('hidden')

    $('body').toggleClass('toggle-open')

    if $toggleText.text() is "View Book Description"
      $toggleText.text('Hide Book Description')
      $toggleIndicator.toggleClass('icon-angle-down').toggleClass('icon-angle-up')
    else
      $toggleText.text('View Book Description')
      $toggleIndicator.toggleClass('icon-angle-down').toggleClass('icon-angle-up')



$(document).on('page:load ready', ready)