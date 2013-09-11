class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_many :results

  validates :first_name, :last_name, presence: true

  def full_name
  	"#{first_name} #{last_name}"
  end
end
