# frozen_string_literal: true
module Api
  module V1
    class AuthenticatedController < BaseController
      before_action :authorize_user!
      before_action :set_paper_trail_whodunnit
      
      def current_user
        @current_user
      end

      private

      def authorize_user!
        @tv = UserSessionValidator.new
        
        begin
        # validate parameters
        token = request.headers['HTTP_AUTHENTICATION_TOKEN'] || request.headers['Authentication_Token']
        raise 'Missing authentication_token' if token.blank?
        @tv.validate!(token)
        @current_user = @tv.user
        rescue UserSessionValidator::TokenValidatorError => e
          raise e.message
        end
      end

      #Set user reference to paper trail
      def set_paper_trail_whodunnit
        PaperTrail.request.whodunnit = current_user.id if current_user
      end
    end
  end
end
