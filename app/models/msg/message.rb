class Msg::Message < ActiveRecord::Base

  belongs_to :group

  validates :group_id, :name, :content, presence: true
  validate :has_contacts

  after_create :send_sms

  def has_contacts
    errors.add(:group_id, 'el grupo debe tener al menos un contacto') if group.contacts.size <= 0
  end

  private
    def send_sms
      require 'twilio-ruby'
      # put your own credentials here
      account_sid = 'AC74e95600708da6a1ced2643103d24bad'
      auth_token = '16f8bc4f85581b264c92ee1fde0a216d'

      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token

      phones = group.contacts.collect{|g| g[:phone]}
      phones.each do |phone|
        @client.account.messages.create(
          from: '+12107141396',
          to: "+503#{phone}",
          body: self.content
        )
      end
    end
end
