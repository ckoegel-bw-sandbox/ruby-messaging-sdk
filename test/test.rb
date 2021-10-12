require 'test/unit'
require_relative '../lib/openapi_client.rb'
include OpenapiClient

begin
    BW_USERNAME = ENV.fetch("BW_USERNAME")
    BW_PASSWORD = ENV.fetch("BW_PASSWORD")
    BW_ACCOUNT_ID = ENV.fetch("BW_ACCOUNT_ID")
    BW_VOICE_APPLICATION_ID = ENV.fetch("BW_VOICE_APPLICATION_ID")
    BW_MESSAGING_APPLICATION_ID = ENV.fetch("BW_MESSAGING_APPLICATION_ID")
    BASE_CALLBACK_URL = ENV.fetch("BASE_CALLBACK_URL")
    BW_NUMBER = ENV.fetch("BW_NUMBER")
    USER_NUMBER = ENV.fetch("USER_NUMBER")
rescue
    puts "Environmental variables not found"
    exit(-1)
end

class IntegrationTest < Test::Unit::TestCase
    OpenapiClient.configure do |config|
        # Configure HTTP basic authorization: httpBasic
        config.username = BW_USERNAME
        config.password = BW_PASSWORD
      end
    
      $api_instance_msg = OpenapiClient::MessagesApi.new()

      def test_create_message
        body = OpenapiClient::MessageRequest.new(
            application_id: BW_MESSAGING_APPLICATION_ID,
            to: [USER_NUMBER],
            from: BW_NUMBER,
            text: "ruby sdk test"
        )
        response = $api_instance_msg.create_message(BW_ACCOUNT_ID, body)
        assert(response::id.length > 0, "id value not set") # validate a message was created and its id exists
      end

      def test_create_message_invalid_phone_number
        body = OpenapiClient::MessageRequest.new(
            application_id: BW_MESSAGING_APPLICATION_ID,
            to: ["+1invalid"],
            from: BW_NUMBER,
            text: "ruby sdk test"
        )
        begin
            $api_instance_msg.create_message(BW_ACCOUNT_ID, body)
            #workaround to make sure that if the error below is not raised, the build will fail
            assert(false, "Expected exception not raised")
        rescue MessagingException => e
            assert(e.description.length > 0, "description value not set")
        end
    end
end
