class ApplicationController < ActionController::Base
  #TODO переделать чтобы была валидация приложений, которые отправляет координаты
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
end
