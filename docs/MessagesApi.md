# OpenapiClient::MessagesApi

All URIs are relative to *https://messaging.bandwidth.com/api/v2*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_message**](MessagesApi.md#create_message) | **POST** /users/{accountId}/messages | Create Message |
| [**get_messages**](MessagesApi.md#get_messages) | **GET** /users/{accountId}/messages | Get Messages |


## create_message

> <BandwidthMessage> create_message(account_id, message_request)

Create Message

Endpoint for sending text messages and picture messages using V2 messaging.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: httpBasic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::MessagesApi.new
account_id = '900000' # String | User's account ID
message_request = OpenapiClient::MessageRequest.new({application_id: '93de2206-9669-4e07-948d-329f4b722ee2', to: ['to_example'], from: '+15551113333'}) # MessageRequest | 

begin
  # Create Message
  result = api_instance.create_message(account_id, message_request)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MessagesApi->create_message: #{e}"
end
```

#### Using the create_message_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<BandwidthMessage>, Integer, Hash)> create_message_with_http_info(account_id, message_request)

```ruby
begin
  # Create Message
  data, status_code, headers = api_instance.create_message_with_http_info(account_id, message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <BandwidthMessage>
rescue OpenapiClient::ApiError => e
  puts "Error when calling MessagesApi->create_message_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **account_id** | **String** | User&#39;s account ID |  |
| **message_request** | [**MessageRequest**](MessageRequest.md) |  |  |

### Return type

[**BandwidthMessage**](BandwidthMessage.md)

### Authorization

[httpBasic](../README.md#httpBasic)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## get_messages

> <BandwidthMessagesList> get_messages(account_id, opts)

Get Messages

Gets a list of messages based on query parameters.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: httpBasic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::MessagesApi.new
account_id = '900000' # String | User's account ID
opts = {
  message_id: '9e0df4ca-b18d-40d7-a59f-82fcdf5ae8e6', # String | The ID of the message to search for. Special characters need to be encoded using URL encoding
  source_tn: '%2B15554443333', # String | The phone number that sent the message
  destination_tn: '%2B15554443333', # String | The phone number that received the message
  message_status: 'RECEIVED', # String | The status of the message. One of RECEIVED, QUEUED, SENDING, SENT, FAILED, DELIVERED, ACCEPTED, UNDELIVERED
  message_direction: 'OUTBOUND', # String | The direction of the message. One of INBOUND, OUTBOUND
  carrier_name: 'Verizon', # String | The name of the carrier used for this message. Possible values include, but are not limited to, Verizon and TMobile. Special characters need to be encoded using URL encoding (i.e. AT&T should be passed as AT%26T)
  message_type: 'mms', # String | The type of the message. One of mms, sms
  error_code: 9902, # Integer | The error code of the message
  from_date_time: '2016-09-14T18:20:16.000Z', # String | The start of the date range to search in ISO 8601 format. Uses the message receive time. The date range to search in is currently 14 days.
  to_date_time: '2016-09-14T18:20:16.000Z', # String | The end of the date range to search in ISO 8601 format. Uses the message receive time. The date range to search in is currently 14 days.
  page_token: 'gdEewhcJLQRB5', # String | A base64 encoded value used for pagination of results
  limit: 50 # Integer | The maximum records requested in search result. Default 100. The sum of limit and after cannot be more than 10000
}

begin
  # Get Messages
  result = api_instance.get_messages(account_id, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MessagesApi->get_messages: #{e}"
end
```

#### Using the get_messages_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<BandwidthMessagesList>, Integer, Hash)> get_messages_with_http_info(account_id, opts)

```ruby
begin
  # Get Messages
  data, status_code, headers = api_instance.get_messages_with_http_info(account_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <BandwidthMessagesList>
rescue OpenapiClient::ApiError => e
  puts "Error when calling MessagesApi->get_messages_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **account_id** | **String** | User&#39;s account ID |  |
| **message_id** | **String** | The ID of the message to search for. Special characters need to be encoded using URL encoding | [optional] |
| **source_tn** | **String** | The phone number that sent the message | [optional] |
| **destination_tn** | **String** | The phone number that received the message | [optional] |
| **message_status** | **String** | The status of the message. One of RECEIVED, QUEUED, SENDING, SENT, FAILED, DELIVERED, ACCEPTED, UNDELIVERED | [optional] |
| **message_direction** | **String** | The direction of the message. One of INBOUND, OUTBOUND | [optional] |
| **carrier_name** | **String** | The name of the carrier used for this message. Possible values include, but are not limited to, Verizon and TMobile. Special characters need to be encoded using URL encoding (i.e. AT&amp;T should be passed as AT%26T) | [optional] |
| **message_type** | **String** | The type of the message. One of mms, sms | [optional] |
| **error_code** | **Integer** | The error code of the message | [optional] |
| **from_date_time** | **String** | The start of the date range to search in ISO 8601 format. Uses the message receive time. The date range to search in is currently 14 days. | [optional] |
| **to_date_time** | **String** | The end of the date range to search in ISO 8601 format. Uses the message receive time. The date range to search in is currently 14 days. | [optional] |
| **page_token** | **String** | A base64 encoded value used for pagination of results | [optional] |
| **limit** | **Integer** | The maximum records requested in search result. Default 100. The sum of limit and after cannot be more than 10000 | [optional] |

### Return type

[**BandwidthMessagesList**](BandwidthMessagesList.md)

### Authorization

[httpBasic](../README.md#httpBasic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

