var ready

ready = function () {
  $('body').on('DOMNodeInserted', function () {
    make_radio_from_checkbox()
  })
}

function make_radio_from_checkbox () {
  $('.answer_field').click(function () {
    $('.answer_field').not(this).attr('checked', false)
  })
}

$(document).ready(ready)
$(document).on('page:load', ready)