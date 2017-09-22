class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #acts_as_paranoid 
  #validates_presence_of :userid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:userid]


   def is_admin?
  	return true if self.role == "admin"
   end	  

  def is_finance?
  	return true if self.role == "finance"
  end	 

  #def is_moderator?
  	#return true if self.role == "moderator"
  #end	   
end
