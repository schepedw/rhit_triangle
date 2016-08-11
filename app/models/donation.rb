class Donation < ActiveRecord::Base
  has_many :installments
  belongs_to :member
  after_create :generate_installment
  alias_attribute :donor, :member

  def generate_installment
    Installment.create(donation_id: id, amount: recurring_amount)
  end

  #TODO: rename this method
  def amount(date = Date.today)
    installments.where('created_at <= ?', date).to_a.sum(&:amount)
  end

  def anonymous=(anonymity)
    anonymity == '1' ?  self.visibility = 'private' : self.visibility = 'public'
  end

  def attributes_with_donor_name
    donor_name = visibility == 'private' ? 'Anonymous' : donor.full_name
    attributes.merge(donor_name: donor_name)
  end
end
