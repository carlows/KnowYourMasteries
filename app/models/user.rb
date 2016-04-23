class User < ActiveRecord::Base
  belongs_to :team
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
