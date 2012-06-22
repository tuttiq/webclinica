class CreateContactInfo < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :type
      t.string :value
      t.references :reachable, :polymorphic => true
      t.timestamps
    end
  end
end
