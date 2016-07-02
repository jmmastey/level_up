class UnsubscribeController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :find_unsubscribe_by_token
  before_action :find_unsubscribe_by_user

  def confirm
    unless @link.present?
      redirect_to :index
      return
    end

    @link.user.update_attributes!(email_opt_out: "unsubscribed")
  end

  private

  def find_unsubscribe_by_token
    return unless params[:token].present?
    @link = UnsubscribeLink.where(token: params[:token]).first
  end

  def find_unsubscribe_by_user
    return if params[:token].present?
    return unless current_user.present?
    @link = UnsubscribeLink.for_user(current_user)
  end
end
