class TicketsController < ApplicationController
  respond_to :html
  before_action :set_ticket, only: [:show, :update]

  def show
    @comment = @ticket.ticket_comments.build
  end

  def new
    @ticket = Ticket.new
    @ticket.ticket_comments.build
  end

  def create
    @ticket = Ticket.create(new_ticket_params)
    respond_with(@ticket, location: -> { ticket_path(@ticket) })
  end

  def update
    @ticket.update(update_ticket_params)
    respond_with(@ticket) do |format|
      if @ticket.errors.empty?
        flash[:notice] = 'Ticket was successfully updated.'
        format.html { redirect_to @ticket }
      else
        @comment = @ticket.ticket_comments.last.new_record? ? @ticket.ticket_comments.last : @ticket.ticket_comments.build
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find_by_reference!(params[:reference])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_ticket_params
      params.require(:ticket).permit(:customer, :title, :department_id, ticket_comments_attributes: [:body])
    end

    def update_ticket_params
      params.require(:ticket).permit(ticket_comments_attributes: [:body])
    end
end
