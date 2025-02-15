class User < ApplicationRecord
  has_secure_password  # 这个方法必须存在，Rails 才能支持 `password=` 方法

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
end
