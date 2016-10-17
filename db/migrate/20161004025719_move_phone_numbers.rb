class MovePhoneNumbers < ActiveRecord::Migration
  def change
    ActiveOfficer.includes(:member).select(:member_id).map(&:member).each do |member|
      next if member.first_name == 'Cary'
      PhoneNumber.create!(member_id: member.member_id, phone_number: member.phone_number, primary: true)
    end

    AlumniOfficer.includes(:member).select(:member_id).map(&:member).each do |member|
      PhoneNumber.create!(member_id: member.member_id, phone_number: member.phone_number, primary: true)
    end
    remove_column :members, :phone_number
  end
end
