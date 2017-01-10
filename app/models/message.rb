class Message < ActiveRecord::Base
  # This is poorly designed. Name, Dorm & phone number belong on a `contact` class or smn.
  # to, from, cc, bcc should also be references to the contact class

  attr_accessor :to, :cc, :bcc, :from, :attachments, :dorm, :phone_number
  belongs_to :sender, class_name: 'contact'
  delegate :sender_name, :sender_name=, :sender_dorm, :sender_dorm=, :sender_phone_number, :sender_phone_number=,
           to: :sender

  def sender
    super || Contact.new
  end
end
