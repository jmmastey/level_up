module ApplicationHelper
  def admin_email
    ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  end

  def feedback_link_classes
    if session[:feedback_seen].present? && session[:feedback_seen] >= Date.today
      "btn feedback-link"
    else
      session[:feedback_seen] = Date.today
      "btn feedback-link wobble"
    end
  end
end
