class Admin::StatusesController < ApplicationController
  respond_to :html
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :set_data, only: [:new, :create, :edit, :update]

  def index
    @statuses = Status.order(:sorter).page(params[:page])
  end

  def new
    @status = Status.new
  end

  def edit
  end

  def create
    @status = Status.create(status_params)
    respond_with(@status, location: -> { admin_statuses_path })
  end

  def update
    @status.update(status_params)
    respond_with(@status, location: -> { admin_statuses_path })
  end

  def destroy
    @status.destroy
    respond_with(@status) do |format|
      if @status.errors.empty?
        flash[:notice] = 'Status was successfully removed.'
      else
        flash[:alert] = @status.errors.messages[:base].join
      end
      format.html { redirect_to admin_statuses_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:title, :status_group_id, :sorter)
    end

    def set_data
      @status_groups = StatusGroup.for_user
    end
end
