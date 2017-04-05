module Admin
  class UsersController < AdminController
    def index
      @users = User.all
    end

    def activate
      @user = User.where(params[:phone]).first
      if @user.confirm_phone(params[:verification_code])
        flash[:notice] = "Пользователь #{@user.phone} активирован"
        redirect_to admin_users_url
      else
        flash[:error] = 'Не удалось зарегестрироваться'
        redirect_to admin_users_url
      end
    end

    def user_params
      params.require(:user).permit(:phone, :verification_code_digest)
    end
  end
end