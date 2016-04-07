class Contact < ActiveRecord::Base
  def sender_dorm; dorm; end
  def sender_dorm=(dorm); self.dorm=(dorm); end
  def sender_phone_number; phone_number; end
  def sender_phone_number=(number); self.phone_number=(number); end
  def sender_name; name; end
  def sender_name=(name); name=(name); end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(full_name)
    name_components = full_name.split(' ')
    self.first_name = name_components[0]
    self.last_name = name_components[1..-1].join(' ')
  end
end
