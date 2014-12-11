class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string  :name
      t.string  :address
      t.string  :phone

      t.integer :chief_id
      t.integer :accountant_id
      t.integer :head_company_id

      t.timestamps
    end
  end
end
