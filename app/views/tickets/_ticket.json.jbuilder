json.extract! ticket, :id, :reference, :customer_id, :title, :body, :department_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
