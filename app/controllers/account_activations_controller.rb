class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "email_activated.success"
      redirect_to user
    else
      flash[:danger] = t "email_activated.danger"
      redirect_to root_url
    end
  end
end
