init_modules = ->
  $(".exercise button").click ->
    self = $(this)
    completedClass = 'fa-check-circle-o'
    uncompletedClass = 'fa-circle-o'

    self.parent(".completion").addClass("active")
    method = if self.hasClass('completed') then 'delete' else 'post'

    $.ajax self.data("target"),
      method: method,
      dataType: 'json',
      complete: -> self.parent(".completion").removeClass("active"),
      success:  (response) ->
        handle = ".dot-" + self.parents(".panel").eq(0).attr('id')
        if response.complete
          self.addClass('completed')
          self.parents('.completion').addClass('just_completed')
          $(handle).removeClass(uncompletedClass).addClass(completedClass)
        else
          self.removeClass('completed')
          $(handle).removeClass(completedClass).addClass(uncompletedClass)

  $(".completion .feedback a").click ->
    exercise = $(this).parents(".exercise").find("h3").text().trim()
    $("#feedback_form #page").val(exercise)

$(document).ready(init_modules)
$(document).on('page:load', init_modules)
