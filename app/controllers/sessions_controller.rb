class SessionsController < ApplicationController
  def create
    user = User.find_by(firstname: params[:session][:firstname])
  
  #  if user&.authenticate(params[:session][:lastname])
      # ログイン成功時の処理
  #    redirect_to calendars_path, notice: 'ログインに成功しました。'
   # else
      # ログイン失敗時の処理
    #  flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
     # render :new
  #  end
  end
end


