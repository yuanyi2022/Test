class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
          # Define the role enum
  enum role: { user: 0, admin: 1 }
  before_create :set_uuid
  has_many :orders
  private
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
