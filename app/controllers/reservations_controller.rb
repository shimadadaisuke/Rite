class ReservationsController < ApplicationController


  def new
    @reservation = Reservation.new
    if params[:date].present?
      @reservation.date = params[:date]
      @formatted_date = Date.parse(params[:date]).strftime("%Y/%m/%d（#{%w(日 月 火 水 木 金 土)[Date.parse(params[:date]).wday]}曜日）")
      session[:formatted_date] = @formatted_date

    end

    if params[:start_time].present?
      @reservation.start_time = params[:start_time]

      @formatted_starttime = @reservation.start_time
      @start_time = params[:start_time]
      session[:start_time] = @start_time

    end

    @products = Product.all
  end

  
  def create
    @formatted_date = session[:formatted_date]
    @start_time = session[:start_time] 
    
    selected_product_ids = params[:reservation][:product_ids]
    
    # 他の処理や保存などを行う
    redirect_to confirm_reservations_path(selected_product_ids: selected_product_ids, formatted_date: @formatted_date, start_time: @start_time)

  end



  def create_confirm
    @reservation = Reservation.new(reservation_params)
    # 必要な処理を追加する（例: データの保存など）
    @selected_product_ids = params[:selected_product_ids]
    @selected_products = Product.where(id: @selected_product_ids)
    render 'confirm'
  end

  def confirm
    @formatted_date = params[:formatted_date]
    @start_time = session[:start_time] 
   
    @selected_product_ids = params[:selected_product_ids]
    @date = params[:date]
    @selected_products = Product.where(id: @selected_product_ids)
    selected_product_price = params[:selected_product_ids]

    @total_price = Product.where(id: selected_product_price).sum(:price)

  
    if @date.present?
      @reservation = Reservation.new(date: Date.parse(@date), start_time: @start_time)
    else
      # @dateがnilの場合の処理を追加する（例: エラーハンドリング）
    end
  end
  
  
  
  
  
  private

  def reservation_params
    params.require(:reservation).permit(:date, :start_time, :other_attribute1, :other_attribute2)  # 必要な属性を追加する
  end

  # 他のアクションやプライベートメソッドなど...
end
