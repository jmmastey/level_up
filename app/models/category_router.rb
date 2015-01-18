module CategoryRouter
  def find_category!(params, user, model = Category)
    authorize_user!(user, params[:organization])

    params = { handle: params[:category], organization: params[:organization] }
    model.find_by!(params)
  end

  def self.path_for(cat, urls = Rails.application.routes.url_helpers)
    params = { category: cat.handle, organization: cat.organization }
    urls.category_path(params)
  end

  private

  def authorize_user!(user, organization)
    return if user && user.admin?
    fail if organization && organization != user.organization
  end
end
