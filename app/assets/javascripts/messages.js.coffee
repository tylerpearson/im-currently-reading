# on load and turbolinks page change
ready = () ->

    $("#book-title-input").keyup (e) ->
        if e.keyCode is 13
            $('.next-button').click()


    $('#new_message').on 'submit', () ->
        localStorage.setItem('username', $('#message_twitter_username').val())

    username = localStorage.getItem('username')

    unless name is undefined or name is null
        $('#message_twitter_username').val(username)



$(document).on('page:load ready', ready)


##
# Message/book view page
##

# show/hide book description tab
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


##
# New message/book page (showing as the homepage currently)
##



$(document).on 'focus', '#book-title-input', () ->
    $nextButton = $('.next-button')
    $nextButton.addClass('show-me') unless $nextButton.hasClass('show-me')

$(document).on 'click', '.next-button', () ->
    $('.step-1').fadeOut(225, () ->

        # get the entered title of the book
        bookTitle = $('#book-title-input').val()

        # get books from the api that match
        $.ajax '/api/books.json',
          data :
              title : bookTitle
          success  : (res, status, xhr) ->

              booksData      = res
              templateScript = $("#book-template").html()
              template       = Handlebars.compile(templateScript)

              $("#matching-books").append(template(booksData))

              $('.step-2').fadeIn(1000).removeClass('loading')

          error    : (xhr, status, err) ->
              alert("Oh no! There was an error: " + err)
              $('.step-1').fadeIn(1000)
          complete : (xhr, status) ->
              #console.log(xhr, status)
      )

$(document).on 'click', '.book-preview', (e) ->
    e.preventDefault()

    $this  = $(@)
    bookId = $(@).data('amazon-asin-id')

    $('#amazon_asin').val(bookId)

    $('.step-2').fadeOut 225, () ->
        $('.step-3').fadeIn(1000)


##
# Addition helper for Handlebars
##
Handlebars.registerHelper "addition", (context, options) ->
  context + parseFloat(options.hash.to)