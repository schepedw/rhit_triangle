class MakeConfirmableMember < ActiveRecord::Migration
  def up
    ## Confirmable
    add_column :members, :confirmation_token, :string
    add_column :members, :confirmed_at, :datetime
    add_column :members, :confirmation_sent_at, :datetime
    add_column :members, :unconfirmed_email, :string
  end

  def down
    remove_column :members, :confirmation_token
    remove_column :members, :confirmed_at
    remove_column :members, :confirmation_sent_at
    remove_column :members, :unconfirmed_email
  end
end
