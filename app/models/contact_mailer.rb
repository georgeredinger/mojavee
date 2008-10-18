class ContactMailer < ActionMailer::Base
  

  def message(message )
    subject    message.subject
    recipients  CONTACT_RECIPIENT
    from      message.email
    sent_on    Time.now
    
    body       :message => message
  end

end
