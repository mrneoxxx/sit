class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  private

    def set_current_user
      User.current = current_admin
    end
end
