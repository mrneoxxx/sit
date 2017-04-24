class TicketMailer < ApplicationMailer
  def new_ticket(id)
    @ticket = Ticket.find(id)
    mail(to: @ticket.customer, subject: t('mail.create_ticket'))
  end

  def update_ticket(id)
    @ticket = Ticket.find(id)
    mail(to: @ticket.customer, subject: t('mail.update_ticket'))
  end
end
