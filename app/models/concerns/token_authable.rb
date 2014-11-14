module TokenAuthable
  extend ActiveSupport::Concern

  def authentication_token=(token)
    write_attribute(:authentication_token, ::BCrypt::Password.create(token))
  end

  def authentication_token
    read_attribute(:authentication_token).try(:tap) do |token|
      ::BCrypt::Password.new(token)
    end
  end

  module ClassMethods
    def from_token_auth(args)
      return unless args[:auth_email].presence && args[:auth_token].presence

      self.find_by(email: args[:auth_email]).try(:tap) do |record|
        (record.authentication_token == args[:auth_token]) && record
      end
    end
  end
end
