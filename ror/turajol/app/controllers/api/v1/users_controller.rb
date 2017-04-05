module Api::V1
  class UsersController < ::Api::ApiController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    skip_before_action :authenticate

    def start_registration
      @user = User.new(user_params)
      if @user.save
        send_verification_code(@user)
        render json: {message: 'You should confirm phone'}, status: :ok
      else
        render json: @user.errors, status: 400
      end
    end

    def confirm
      @user = User.where(phone: user_params[:phone]).first
      return render json: {message: 'Не правильный телефон. Попробуйте еще раз'}, status: 404 if @user.blank?

      if @user.confirm_phone(user_params[:verification_code])
        render json: {auth_token: @user.token}
      else
        render json: {message: 'Не правильный ОТП. Попробуйте еще раз'}, status: 404
      end
    end

    def send_verification_code(user)
      puts user.verification_code
    end

    def user_params
      params.require(:user).permit(:phone, :verification_code)
    end

    def not_found
      render json: {message: "Пользователь с таким телефоном '#{user_params[:phone]}' не найден"}, status: 404
    end
  end
end