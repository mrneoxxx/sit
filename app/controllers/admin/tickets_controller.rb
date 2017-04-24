module Admin
  class TicketsController < BaseController
    respond_to :html
    before_action :set_admin_ticket, :set_data, only: [:show, :update]

    def index
      @tickets = Ticket.preload(:status, :department, :user).status_group(params.dig(:q, :status_group))
                     .query_search(params.dig(:q, :query)).page(params[:page])
    end

    def show
      @comment = @ticket.ticket_comments.build
    end

    def new
      @ticket = Ticket.new
      @ticket.ticket_comments.build
    end

    def create
      @ticket = Ticket.create(new_admin_ticket_params)
      respond_with(@ticket, location: -> { admin_ticket_path(@ticket) })
    end

    def update
      @ticket.update(update_admin_ticket_params)
      respond_with(@ticket) do |format|
        if @ticket.errors.empty?
          flash[:notice] = 'Ticket was successfully updated.'
          format.html { redirect_to @ticket }
        else
          @comment = @ticket.ticket_comments.last.new_record? ?  @ticket.ticket_comments.last : @ticket.ticket_comments.build
          format.html { render :show }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_ticket
        @ticket = Ticket.preload(ticket_comments: [:assignment, :user]).find_by_reference!(params[:reference])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def update_admin_ticket_params
        params.require(:ticket).permit(:status_id, :user_id, ticket_comments_attributes: [:body])
      end

      def new_admin_ticket_params
        params.require(:ticket).permit(:customer, :title, :department_id, ticket_comments_attributes: [:body])
      end

      def set_data
        @statuses = Status.order(:sorter)
      end
  end
end