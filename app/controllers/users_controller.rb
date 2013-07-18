class UsersController < ApplicationController
  before_filter :authenticate ,:only =>[:index,:edit,:update,:destroy,:following,:followers]
  before_filter :correct_user ,:only =>[:edit,:update]
   before_filter :admin_user ,:only =>:destroy

  	 def index
  	 	# @users=User.all
  	 	@users=User.paginate(:page=>params[:page],:per_page => 4)
  	 	@title ="All USER"
  	 end



	 def show
	  	@user= User.find(params[:id])
	  	@microposts=@user.microposts.paginate(:page=>params[:page],:per_page => 10)
	  	@title= @user.name
	 end


	 def following
	 	@title="Following"
 		@user= User.find(params[:id])
 		@users=@user.following.paginate(:page=>params[:page])
	 render 'show_follow'
	 end

	def followers
		@title="Followers"
 		@user= User.find(params[:id])
 		@users=@user.followers.paginate(:page=>params[:page])
	render 'show_follow'
	end


	 def new
	  	@user = User.new
	  	@title ="Sign Up"
	 end
 
	 def create
	 	 @user = User.new(params[:user])
	 	 if @user.save
	 	 	sign_in @user
	 	 	#handle a successful save.
	 	 	#flash[:success]="Welcome"
	 	 	redirect_to @user, :flash => {:success => "Welcome #{@user.name}"}
	 	 else
	 	    @title ="Sign Up"
	 	    render 'new'
	 	 end
	 end

	 def edit

	    @user= User.find(params[:id])
	 	@title ="Edit User"
	 end

	 def update
	 	 @user= User.find(params[:id])
	 	 if @user.update_attributes(params[:user])
	 	 	#it worked
	 	 	redirect_to @user, :flash => {:success => "Profile Update!!"}
	 	 	else
	 	 		@title ="Edit User"
	 			render'edit'
	 	 end 	
	 end


	 def destroy
	 	@user=User.find(params[:id]).destroy
	 	#flash[:success]="User Deleted"
	 	redirect_to users_path,:flash =>{:success => "#{@user.name} was Deleted"}
	 end
 	private

 	# session helpe
 	# def authenticate
 		
 	# 	deny_access unless signed_in?

 	# end
 	# def deny_access
 	# 	#redirect_to signin_path flash[:error]="Please Signgn in to access this Page !!!"
 	# 	redirect_to signin_path, :notice =>"Please Signgn in to access this Page !!!"
 		
 	# end
 	def correct_user
 		@user=User.find(params[:id])
 		#redirect_to(root_path)  unless @user ==current_user
 		redirect_to(root_path)  unless current_user?(@user)
 	end
 	def admin_user
 		@user=User.find(params[:id])
 			#redirect_to(root_path) 
 		redirect_to users_path,  :notice => " #{@user.name.capitalize} IS A ADMIN !!!" if (!current_user.admin? || current_user?(@user))
 	end

end

