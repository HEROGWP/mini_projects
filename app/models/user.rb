class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 50
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  def admin?
  	self.role == "admin"
  end
end
