module Api
  class ApiController < ActionController::API
    #TODO переделать чтобы была валидация приложений, которые отправляет координаты
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
    add_flash_types :error, :success
  end
end



