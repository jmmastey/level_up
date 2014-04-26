module ApplicationHelper

  def user_role
    if current_user.present? && current_user.admin?
      "(admin)"
    else
      ""
    end
  end
end
