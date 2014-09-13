module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      when /the home\s?page/ then '/'
      when /the sign up page/ then '/users/sign_up'
      when /the sign in page/ then '/users/sign_in'
      else dereference_page_name(page_name)
    end
  end

  def dereference_page_name(page_name)
    page_name =~ /the (.*) page/
    path_components = $1.split(/\s+/)
    send(path_components.push('path').join('_').to_sym)
  rescue
    raise "Can't find mapping from \"#{page_name}\" to a path.\n /
      Now, go and add a mapping in #{__FILE__}"
  end
end

World(NavigationHelpers)
