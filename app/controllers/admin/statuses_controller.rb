class Admin::StatusesController < ApplicationController
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
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to admin_statuses_path, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: admin_statuses_path }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to admin_statuses_path, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_statuses_path }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/statuses/1
  # DELETE /admin/statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to admin_statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
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
