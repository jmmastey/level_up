init_home = ->
  $('.activity-feed .item').tooltip()
  $('.difficulty .fa').tooltip()
  $("#feedback_form .submit").click ->
    form = $("#feedback_form form").eq(0)
    $.ajax form.attr("target"),
      method: 'POST'
      dataType: 'json',
      complete: ->
        $("#feedback_form").modal("hide")
        $("#message").val('')
      data: {
        name: $("#name", form).val(),
        page: $("#page", form).val(),
        message: $("#message", form).val(),
      }

  $('[data-width]').each(->
    width = $(this).data('width') + "%"
    $(this).css('width', width)
  )

$(document).ready(init_home)
$(document).on('page:load', init_home)
