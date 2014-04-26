class HomeController < ApplicationController

  def show
    render "modules/#{params[:module]}"
  end

end
