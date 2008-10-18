require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
def test_message
    @message = Message.new(:name => 'Bob',:email => 'bob@example.com', :company => "some company",
          :phone => '123.456.789', :subject => 'test subject')

test_body = <<EOF
Email from your web site

From:  Bob

Company:  Acme

Phone 123.456.7890

Message: please test me
EOF

created = ContactMailer.create_message(@message)
assert_equal 2, created.parts.size

assert_equal "multipart/alternative" , created.content_type
assert_equal "text/plain", created.parts[0].content_type
assert_equal "text/html", created.parts[1].content_type
assert_equal test_body, created.parts[0].body
end

end

