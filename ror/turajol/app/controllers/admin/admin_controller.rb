module Admin
  class AdminController < ActionController::Base
    NAME = ENV.fetch("LOGIN"){"admin"}
    PASSWORD = ENV.fetch("PASSWORD"){"admin"}
    protect_from_forgery with: :exception
    add_flash_types :error, :success

    http_basic_authenticate_with name: NAME, password: PASSWORD
  end
end

