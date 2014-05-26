$ ->
  $(".exercise button").click ->
    self = $(this)

    self.parent(".completion").addClass("active")
    method = if self.hasClass('completed') then 'delete' else 'post'

    $.ajax self.attr("target"),
      method: method,
      dataType: 'json',
      complete: -> self.parent(".completion").removeClass("active"),
      success:  (response) ->
        if response.complete
        	self.addClass('completed')
        else
        	self.removeClass('completed')
