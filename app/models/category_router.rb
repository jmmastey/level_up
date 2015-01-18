class CategoryRouter
  def self.find(handle, organization)
    Category.find_by!(handle: handle, organization: organization)
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError
  end

  def self.path_to(category)
    url_helpers.category_path(category: category.handle,
                              organization: category.organization)
  end

  def self.url_helpers
    Rails.application.routes.url_helpers
  end
end
