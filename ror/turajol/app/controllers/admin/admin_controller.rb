module Admin
  class AdminController < ApplicationController
    NAME = ENV.fetch("LOGIN"){"admin"}
    PASSWORD = ENV.fetch("PASSWORD"){"admin"}

    protect_from_forgery with: :exception
    http_basic_authenticate_with name: NAME, password: PASSWORD

    add_flash_types :error, :success
  end
end

