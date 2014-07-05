class HomeController < ApplicationController

  def index
    @user_courses = Course.enrolled_courses_for(current_user)
    @category_summary = CategorySummary.summarize_user(current_user)
  end

  def show
    render "modules/#{params[:module]}"
  end

end
