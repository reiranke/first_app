



class RelationshpsController < ApplicationController
	before_filter :authenticate

	def create
		
		#raise params.inspect
		@user=User.find(params[:relationshp][:followed_id])
	current_user.follow!(@user)
	redirect_to @user
	end

	
	def destroy
	@user=Relationshp.find(params[:id]).followed
	current_user.unfollow!(@user)
	redirect_to @user
	end
end




# class RelationshpsController < ApplicationController
# 	before_filter :authenticate

# 	def create
		
# 		#raise params.inspect
# 		@user=User.find(params[:relationshp][:followed_id])
# 	current_user.follow!(@user)
#  respond_to do |format|
# format.html {redirect_to @user}
# format.js
# end

	
# 	end

	
# 	def destroy
# 	@user=Relationshp.find(params[:id]).followed
# current_user.unfollow!(@user)
	
# 	respond_to do |format|
# format.html {redirect_to @user}
# format.js
# end
# 	end
# end