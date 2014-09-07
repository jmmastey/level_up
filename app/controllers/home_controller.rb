class HomeController < ApplicationController
  helper :courses

  def index
    @courses = current_user.courses
    @summary = Summaries.for_user(current_user)
  end

  def show
    render "modules/#{params[:module]}"
  end
end
