class HomeController < ApplicationController

  def index
    if current_user.signed_in?
      @user_courses = Course.enrolled_courses_for(current_user)
      @category_summary = CategorySummary.summarize_user(current_user)
    else
      @user_courses = []
      @category_summary = []
    end
  end

  def show
    render "modules/#{params[:module]}"
  end

end
