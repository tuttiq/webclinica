class AddCrmAndGradyearAndAppointmentpriceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :crm, :string
    add_column :users, :gradyear, :date
    add_column :users, :appointmentprice, :float
  end
end
