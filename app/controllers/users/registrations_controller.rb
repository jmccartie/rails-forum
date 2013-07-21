module Users
  class RegistrationsController < Devise::RegistrationsController
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :username)
    end
    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :username)
    end
    private :sign_up_params
    private :account_update_params
  end

end

