class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :address
      t.string :passport
      t.string :phone
      t.string :email
      t.string :skype
      t.string :almamater
      t.integer :sex

      t.integer :spouse_id
      t.integer :mother_id
      t.integer :father_id

      t.timestamps
    end
  end
end
