class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :website, :location, :signature,
                  :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false
  validates_length_of :name,:within=>3..20
  validates_length_of :email,:within=>6..80
  validates_length_of :password,:maximum=>20
  
  validates_length_of :website,:maximum=>80
  validates_length_of :location,:maximum=>80
  validates_length_of :signature,:maximum=>90  
  
  has_many :books
  has_many :compilations
  has_many :tasks
end
