init_home = ->
  $("#feedback_form .submit").click ->
    form = $("#feedback_form form").eq(0)
    $.ajax form.attr("target"),
      method: 'POST'
      dataType: 'json',
      complete: -> $("#feedback_form").modal("hide")
      data: {
        name: $("#feedback-name", form).val(),
        page: $("#feedback-page", form).val(),
        message: $("#feedback-message", form).val(),
      }

$(document).ready(init_home)
$(document).on('page:load', init_home)
