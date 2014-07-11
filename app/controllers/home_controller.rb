class HomeController < ApplicationController
  helper :courses

  def index
    if current_user.signed_in?
      @courses = current_user.courses
      @category_summary = CategorySummary.user_summary(current_user)
    else
      @courses = []
      @category_summary = []
    end
  end

  def show
    render "modules/#{params[:module]}"
  end

end
