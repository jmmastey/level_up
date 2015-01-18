class CategoryRouter
  def self.find(user, handle, organization)
    authorize_user!(user, organization)
    Category.find_by!(handle: handle, organization: organization)
  rescue ActiveRecord::RecordNotFound
    raise AbstractController::ActionNotFound
  end

  def self.authorize_user!(user, organization)
    if organization.present? && organization != user.organization
      raise AbstractController::ActionNotFound
    end
  end

  def self.path_to(category)
    url_helpers.category_path(category: category.handle,
                              organization: category.organization)
  end

  def self.url_helpers
    Rails.application.routes.url_helpers
  end
end
