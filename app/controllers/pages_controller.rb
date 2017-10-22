class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:report_csp_error]

  # GET /.well-known/acme-challenge/:id
  def letsencrypt
    render text: ENV['LETS_ENCRYPT_CODE']
  end

  # GET /report-csp-error
  def report_csp_error
    if Rails.app.config.force_ssl
      AdminMailer.csp_error(request.body.read).deliver_now!
    end
  end
end
