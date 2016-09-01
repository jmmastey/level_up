class PagesController < ApplicationController
  # GET /.well-known/acme-challenge/:id
  def letsencrypt
    render text: "uuonm85LZUwvqH0todE2UQCbYNmJ_XrHXL9W0HxoPZU.s4NILCReuafy1VQbGsfmxAnpU_2CSuP624LPg4Q6eK0"
  end
end
