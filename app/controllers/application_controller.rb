# frozen_string_literal: true

class ApplicationController < ActionController::API
  
    private
    def admin_authentication
        unless current_user.is_admin
          render json: {"message": "usuário não é admin"}, status: :unauthorized
        end
      end
  
end
