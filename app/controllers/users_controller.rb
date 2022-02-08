class UsersController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction 

  def index
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction)
  end

	# GET /users/new
	# GET /users/new.json
	def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)
    @user.role = "author"

		if @user.save
      SignupMailer.notification(@user).deliver_now
			redirect_to thankyou_path, notice: "Your account has been successfully created."
		else
			render "new"
		end
	end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.email != user_params[:email]
        @user.errors.add(:base, :cannot_change_email, message: "You cannot change your email.")
      end

      if @user.email == user_params[:email] && @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :direction, :sort)
  end

  def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "role"
  end

  def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
