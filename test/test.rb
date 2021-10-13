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
        #config.ssl_verify = false # remove for testing on push
    end
    
    $api_instance_msg = OpenapiClient::MessagesApi.new()
    $api_instance_media = OpenapiClient::MediaApi.new()

    def test_create_message
        message_text = "ruby sdk test"
        body = OpenapiClient::MessageRequest.new(
            application_id: BW_MESSAGING_APPLICATION_ID,
            to: [USER_NUMBER],
            from: BW_NUMBER,
            text: message_text
        )
        response = $api_instance_msg.create_message(BW_ACCOUNT_ID, body)
        $message_id = response::id
        assert_equal(response::text, message_text, "message text does not match") # validate a message was created and its text matches
    end

    def test_get_message
        get_opts = {
            :source_tn => BW_NUMBER
        }
        response = $api_instance_msg.get_messages(BW_ACCOUNT_ID, get_opts)
        assert_equal(response.messages[0].source_tn, BW_NUMBER, "failed to get message from BW_NUMBER")
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
        rescue OpenapiClient::ApiError => e
            resp_body =  JSON.parse(e.response_body)
            expected_err = "\'+1invalid\' must be replaced with a valid E164 formatted telephone number"
            assert_equal(resp_body['fieldErrors'][0]['description'], expected_err, "error description does not match expected")
        end
    end

    def test_all_media
        media_file_name = 'ruby_media_test'
        media_file = '123456'

        #media upload
        begin
            up_response = $api_instance_media.upload_media(BW_ACCOUNT_ID, media_file_name, media_file)
        rescue OpenapiClient::ApiError => e
            puts "Status Code: "+ e.code
            assert(false, "upload media failed")
        end

        #media list
        list_media = $api_instance_media.list_media(BW_ACCOUNT_ID)
        assert_equal(list_media[0].media_name, media_file_name, "could not find media on account")

        #media download
        downloaded_media_file = $api_instance_media.get_media(BW_ACCOUNT_ID, media_file_name, debug_return_type: 'String')
        assert_equal(downloaded_media_file, media_file, "downloaded media file not equal to upload")

        #media delete
        begin
            del_response = $api_instance_media.delete_media(BW_ACCOUNT_ID, media_file_name)
        rescue OpenapiClient::ApiError => e
            puts "Status Code: "+ e.code
            assert(false, "delete media failed")
        end
    end
end
