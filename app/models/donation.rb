class Donation < ActiveRecord::Base
  has_many :installments
  belongs_to :member
  after_create :generate_installment
  alias_attribute :donor, :member

  def generate_installment
    Installment.create(donation_id: id, amount: recurring_amount)
  end

  # TODO: rename this method
  def amount(date = Time.zone.today)
    installments.where('created_at <= ?', date).to_a.sum(&:amount)
  end

  def anonymous=(_anonymity)
    # right now, this only gets called when the the donation is private
    # /projects/2/donations/new
    # TODO: get the frontend to pass real values
    self.visibility = 'private'
  end

  def attributes_with_donor_name
    donor_name = visibility == 'private' ? 'Anonymous' : donor.full_name
    attributes.merge(donor_name: donor_name)
  end
end
