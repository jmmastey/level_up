init_home = ->
  $("#feedback_form .submit").click ->
    form = $("#feedback_form form").eq(0)
    $.ajax form.attr("target"),
      method: 'POST'
      dataType: 'json',
      complete: -> $("#feedback_form").modal("hide")
      data: {
        name: $("#name", form).val(),
        page: $("#page", form).val(),
        message: $("#message", form).val(),
      }

$(document).ready(init_home)
$(document).on('page:load', init_home)
