module ApplicationHelper
  def admin_email
    ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  end
end
