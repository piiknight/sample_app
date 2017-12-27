class SessionsController < ApplicationController
  before_action :set_user, only: :create

  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      check_activated
    else
      flash.now[:danger] = t "login_page.input_error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def set_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def check_activated
    if @user.activated?
      log_in @user
      params[:session][:remember_me] == Settings.User.is_remember_pass ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      message  = t "email_activated.message1"
      message += t "email_activated.message2"
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
