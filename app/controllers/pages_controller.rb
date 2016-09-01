class PagesController < ApplicationController
  # GET /.well-known/acme-challenge/:id
  def letsencrypt
    render text: ENV['LETS_ENCRYPT_CODE']
  end
end
