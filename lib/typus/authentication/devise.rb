module Typus
  module Authentication
    module Devise

      protected

      include Base

      def admin_user
        current_devise_user
      end

      def authenticate
        authenticate_devise_user!
      end

    end
  end
end
