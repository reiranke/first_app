class UsersController < ApplicationController
  
	 def show
	  	@user= User.find(params[:id])
	  	@title= @user.name
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
end

