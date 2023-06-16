class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     # render 'new', layout: 'layouts/application', status: :unprocessable_entity
#      flash[:notice] = '登録しました。3秒後に前の画面に戻ります。'
      #redirect_back(fallback_location: new_session_path)
     # redirect_to new_session_path, notice: '登録が完了しました。'<br>'登録した氏名を入力し、「ご予約画面へ」へお進みください。'
      redirect_to new_session_path, notice: '新規登録が完了しました。'


    else
 #   flash.now[:alert] = '既に登録されています。'
 #   flash.now[:error] = @user.errors.full_messages.first
      render 'new', layout: 'layouts/application', status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:firstname, :lastname)
  end
end
