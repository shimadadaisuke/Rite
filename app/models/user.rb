class User < ApplicationRecord
  # バリデーションや関連付けなどの設定を行う
  #validates :firstname, :lastname, presence: true
  attribute :firstname, :string
  attribute :lastname, :string
  validates :firstname, presence: { message: '苗字（Firstname）を入力してください。' }
  validates :lastname, presence: { message: '名前（Lastname）を入力してください。' }
  validates :firstname, uniqueness: { scope: :lastname, message: '' }, if: :will_save_change_to_firstname?
  validates :lastname, uniqueness: { scope: :firstname, message: '様は、登録済みのお名前です。' }, if: :will_save_change_to_lastname?
#  validates :firstname, uniqueness: { scope: :lastname }, if: :will_save_change_to_firstname?
#  validates :lastname, uniqueness: { scope: :firstname }, if: :will_save_change_to_lastname?
  
end
