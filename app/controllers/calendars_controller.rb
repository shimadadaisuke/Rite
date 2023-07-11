require 'date'
require 'holidays'

class CalendarsController < ApplicationController

  def create
    @firstname = params[:firstname]
    @lastname = params[:lastname]

    # データベースにFirstnameとLastnameの組み合わせが存在するかチェック
    if User.exists?(firstname: @firstname, lastname: @lastname)
      session[:firstname] = @firstname
      session[:lastname] = @lastname
      redirect_to calendars_path
    else
      if @firstname.blank?
        flash.now[:notice] = "苗字（Firstname）が入力されていません。"
      elsif @lastname.blank?
        flash.now[:notice] = "名前（Lastname）が入力されていません。"
      else
#        flash.now[:notice] = "ログインに失敗しました。<br>未登録の方は新規登録をお願いします。氏名に誤りがない場合は、お手数ですが、問い合わせをお願いいたします。"
        flash.now[:notice] = "ログインに失敗しました。<br>-＞未登録の方は新規登録をお願いします。<br>-＞氏名に誤りがない場合は、問い合わせをお願いいたします。".html_safe
      end
      render 'sessions/new', layout: 'layouts/application', status: :unprocessable_entity
    end
  end
  
  
  
  
  
  

  def index
    @firstname = session[:firstname]
    @lastname = session[:lastname]
    @events = Calendar.all
    @current_month = params[:month] ? Date.parse("01-#{params[:month]}-#{Date.today.year}") : Date.today.at_beginning_of_month

    @weeks = []
    start_date = @current_month.at_beginning_of_month
    end_date = @current_month.at_end_of_month
    current_date = start_date.beginning_of_week(:sunday)

    while current_date <= end_date do
      week = []
      7.times do
        if current_date.month == @current_month.month
          week << { date: current_date, events: generate_time_slots(current_date), holidays: japanese_holidays(current_date) }
        else
          week << nil
        end
        current_date += 1.day
      end
      @weeks << week
    end
    
  end

  helper_method :weekend_or_holiday?

  #def new
  #  selected_datetime = params[:date]
  #  selected_date = params[:date]
  #  @selected_datetime = DateTime.parse(selected_datetime) if selected_datetime.present?
  #  @selected_date = Date.parse(params[:date]) if params[:date].present?
  #  @reservation = Reservation.new
  #end
  
  #def new
  #  selected_datetime = params[:date]
  #  @selected_datetime = DateTime.parse(selected_datetime) if selected_datetime.present?
  #  @selected_date = @selected_datetime.to_date if @selected_datetime.present?
  #  @reservation = Reservation.new
  #end
  
  def new
    selected_datetime = CGI.unescape(params[:date]) if params[:date].present?
    puts "selected_datetime: #{selected_datetime}"

    @selected_datetime = DateTime.parse(selected_datetime) if selected_datetime.present?
    @selected_date = @selected_datetime.strftime("%Y/%m/%d（%a）%H:%M") if @selected_datetime.present?
    @reservation = Reservation.new
  end
  
  
  
  

  private

  def generate_time_slots(date)
    return [] if weekend_or_holiday?(date)

    time_slots = []
    if date.month == @current_month.month
      (9..15).step(2) do |hour|
        time_slots << { start_time: "#{hour}:00", end_time: "#{hour + 2}:00" }
      end
    end
    time_slots
  end

  def weekend_or_holiday?(date)
    date.saturday? || date.sunday? || japanese_holidays(date).any?
  end

  def japanese_holidays(date)
    holidays = Holidays.on(date, :jp)
    holidays.map { |holiday| holiday[:name] }
  end
end


