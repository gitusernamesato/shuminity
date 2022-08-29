class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about, :guest_sign_in]
  def top
  end

  def about
  end
  
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト" 
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
