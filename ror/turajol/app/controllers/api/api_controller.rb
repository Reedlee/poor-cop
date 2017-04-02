module Api
  class ApiController < ActionController::Base
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
    add_flash_types :error, :success
  end
end



