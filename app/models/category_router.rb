module CategoryRouter
  def find_category!(params, user, model = Category)
    authorize_user!(user, params[:organization])

    params = { handle: params[:category], organization: params[:organization] }
    model.find_by!(params)
  end

  def self.path_for(category, urls = Rails.application.routes.url_helpers)
    params = { handle: category.handle, organization: category.organization }
    urls.category_path(params)
  end

  private

  def authorize_user!(user, organization)
    fail if organization && organization != user.organization
  end
end
