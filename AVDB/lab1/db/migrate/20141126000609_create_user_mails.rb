class CreateUserMails < ActiveRecord::Migration
  def change
    create_table :user_mails do |t|
      t.string :recipient
      t.string :sender
      t.text :message

      t.timestamps
    end
  end
end
