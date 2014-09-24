class HomeController < ApplicationController
  helper :courses
  before_action :find_module, only: :show

  def index
    @courses = current_user.courses
    @summary = Summaries.for_user(current_user)
  end

  def show
    render "modules/#{@module.handle}"
  end

  private

  def find_module
    @module = Category.find_by!(handle: params[:module])
  end
end
