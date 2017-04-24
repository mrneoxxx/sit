module Admin
  class UsersController < BaseController
    respond_to :html
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.preload(:department).page(params[:page])
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.create(user_params)
      respond_with(@user, location: -> { admin_users_path })
    end

    def update
      @user.update(user_params)
      respond_with(@user, location: -> { admin_users_path })
    end

    def destroy
      @user.destroy
      respond_with(@user) do |format|
        if @user.errors.empty?
          flash[:notice] = 'User was successfully removed.'
        else
          flash[:alert] = @user.errors.messages[:base].join
        end
        format.html { redirect_to admin_users_url }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :department_id)
      end
  end
end