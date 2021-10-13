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
        response = $api_instance_msg.create_message_with_http_info(BW_ACCOUNT_ID, body)
        assert_equal(202, response[1], "incorrect response code")
        assert_equal(29, response[0].id.length, "id not set")
        assert_equal(BW_NUMBER, response[0].owner, "message owner not correct")
        assert_equal(BW_NUMBER, response[0].from, "from number does not match")
        assert_equal([USER_NUMBER], response[0].to, "to number does not match")
        assert_equal(body.tag, response[0].tag, "tags do not match")
        assert_equal(body.media,response[0].media,  "media does not match")
        assert_equal(message_text, response[0].text, "message text does not match")
    end

    def test_get_message
        get_opts = {
            :source_tn => BW_NUMBER,
            :message_direction => "OUTBOUND"
        }
        response = $api_instance_msg.get_messages_with_http_info(BW_ACCOUNT_ID, get_opts)
        assert_equal(200, response[1], "incorrect response code")
        assert_equal(BW_ACCOUNT_ID, response[0].messages[0].account_id, "account ids do not match")
        assert_equal("OUTBOUND", response[0].messages[0].message_direction, "message directions do not match")
        assert_equal(BW_NUMBER, response[0].messages[0].source_tn, "failed to get message from BW_NUMBER")
    end

    def test_create_message_invalid_phone_number
        body = OpenapiClient::MessageRequest.new(
            application_id: BW_MESSAGING_APPLICATION_ID,
            to: ["+1invalid"],
            from: BW_NUMBER,
            text: "ruby sdk test"
        )
        begin
            $api_instance_msg.create_message_with_http_info(BW_ACCOUNT_ID, body)
            assert(false, "Expected exception not raised")
        rescue OpenapiClient::ApiError => e
            resp_body =  JSON.parse(e.response_body)
            expected_desc = "\'+1invalid\' must be replaced with a valid E164 formatted telephone number"
            assert_equal(400, e.code, "incorrect response code")
            assert_equal("request-validation", resp_body['type'], "response type does not match")
            assert_equal(expected_desc, resp_body['fieldErrors'][0]['description'], "error description does not match expected")
        end
    end

    def test_all_media
        media_name = 'ruby_media_test'
        media_data = '123456'

        #media upload
        up_response = $api_instance_media.upload_media_with_http_info(BW_ACCOUNT_ID, media_name, media_data)
        assert_equal(204, up_response[1], "incorrect response code")

        #media list
        list_media = $api_instance_media.list_media_with_http_info(BW_ACCOUNT_ID)
        assert_equal(200, list_media[1], "incorrect response code")
        assert_equal(media_data.length, list_media[0][0].content_length, "incorrect data length")
        assert_equal(media_name, list_media[0][0].media_name, "could not find media on account")

        #media download
        downloaded_media_file = $api_instance_media.get_media_with_http_info(BW_ACCOUNT_ID, media_name, debug_return_type: 'String')
        assert_equal(200, downloaded_media_file[1], "incorrect response code")
        assert_equal(media_data, downloaded_media_file[0], "downloaded media file not equal to upload")

        #media delete
        del_response = $api_instance_media.delete_media_with_http_info(BW_ACCOUNT_ID, media_name)
        assert_equal(204, del_response[1], "incorrect response code")
    end
end
