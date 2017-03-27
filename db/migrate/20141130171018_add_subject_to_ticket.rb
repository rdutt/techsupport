class AddSubjectToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :subject, :string
    add_column :tickets, :zendesk_ticket_url, :string
  end
end
