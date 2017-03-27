class AddProblemUrlToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :problem_url, :string
    add_column :tickets, :consultation_id, :integer
    add_column :tickets, :web_browser, :string
  end
end
