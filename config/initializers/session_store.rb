# Be sure to restart your server when you modify this file.
#
# fuuuuck you deprecated gem
module Kernel
  def quietly_with_deprecation_silenced(&block)
    ActiveSupport::Deprecation.silence do
      quietly_without_deprecation_silenced(&block)
    end
  end
  alias_method_chain :quietly, :deprecation_silenced
end

Levelup::Application.config.session_store :active_record_store
