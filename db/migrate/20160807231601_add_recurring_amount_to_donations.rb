class AddRecurringAmountToDonations < ActiveRecord::Migration
  def up
    add_column :donations, :recurring_amount, :decimal, precision: 7, scale: 2
    execute('WITH donation_amounts AS(
    SELECT donation_id, max(amount) AS amount FROM installments
    GROUP BY donation_id)
    UPDATE donations set recurring_amount = donation_amounts.amount FROM donation_amounts WHERE donations.donation_id = donation_amounts.donation_id')
    change_column_null :donations, :recurring_amount, false
  end

  def down
    remove_column :donations, :recurring_amount
  end
end
