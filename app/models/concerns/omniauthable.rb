module Omniauthable
  extend ActiveSupport::Concern

  module ClassMethods
    def from_omniauth(auth)
      by_auth(auth).first ||
        existing_from_omniauth(auth) ||
        new_from_omniauth(auth)
    end

    def existing_from_omniauth(auth)
      existing = find_by(email: auth.info.email)
      existing && existing.tap do |user|
        user.update!(provider: auth.provider, uid: auth.uid)
      end
    end
    private :existing_from_omniauth

    def new_from_omniauth(auth)
      create(email: auth.info.email,
             password: Devise.friendly_token[0, 20],
             name: auth.info.name,
             provider: auth.provider,
             uid: auth.uid,
            )
    end
    private :new_from_omniauth
  end
end
