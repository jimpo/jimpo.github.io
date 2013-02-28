define ['underscore', 'bootstrap'], (_) ->

  # pageHeights is a hash of each page id to the most recent height
  pageHeights = {}
  setHeight = ->
    pageHeights['#' + $(this).attr('id')] = $(this).height()
  $('#pages .item').each(setHeight)

  # Initialize carousel
  $pages = $('#pages')
  $pages.carousel(interval: false)

  # This is needed so that pages don't get clipped during transitions
  # The height of the .carouser-inner will be set temporarily during transition
  $pages.on 'slide', ->
    setHeight.call($(this).find('.item.active'))
    $(this).children('.carousel-inner').height (index, height) ->
      _.max([pageHeights[pageId()], height])
  $pages.on 'slid', ->
    $(this).children('.carousel-inner').css('height', '')


  # Determine the page id from the current route
  pageId = -> location.hash || "#home"

  load: ->
    index = $pages.find(pageId()).index()
    $pages.carousel(index)
