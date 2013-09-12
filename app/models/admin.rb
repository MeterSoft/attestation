class Admin < ActiveRecord::Base
  include Search
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  validates :first_name, :last_name, presence: true

  has_many :tasks
  has_many :results, through: :tasks
  
  def full_name
  	"#{first_name} #{last_name}"
  end

end
