class HomeController < ApplicationController

  def index
    if current_user.signed_in?
      @courses = Course.enrolled_courses_for(current_user)
      @category_summary = CategorySummary.summarize_user(current_user)
    else
      @courses = []
      @category_summary = []
    end
  end

  def show
    render "modules/#{params[:module]}"
  end

end
