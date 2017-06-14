class DashboardsController < ApplicationController
	 before_action :authenticate_user!
	# load_and_authorize_resource 

	def index
		@accounts=Account.all
	end	
end
