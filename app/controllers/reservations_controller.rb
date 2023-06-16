class ReservationsController < ApplicationController
  before_action :authenticate_user! # Deviseを使用している場合、ログインしているユーザーを確認します

  def new
    @reservation = current_user.reservations.build
    @reservation.reservation_date = params[:date]
    @first_name, @last_name = params[:name]&.split(" ") || ['', '']
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      redirect_to show_reservation_path(@reservation.id), notice: "予約が成功しました。"
    else
      flash.now[:error] = "予約に失敗しました。もう一度お試しください。"
      render :new
    end
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

  def back_to_new
    redirect_to new_reservation_path(date: @reservation.reservation_date, name: [@reservation.first_name, @reservation.last_name].join(" "))
  end

  private

  def reservation_params
    params.require(:reservation).permit(:first_name, :last_name, :reservation_date)
  end
end
