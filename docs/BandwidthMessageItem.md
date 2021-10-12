# OpenapiClient::BandwidthMessageItem

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message_id** | **String** | The message id | [optional] |
| **account_id** | **String** | The account id of the message | [optional] |
| **source_tn** | **String** | The source phone number of the message | [optional] |
| **destination_tn** | **String** | The recipient phone number of the message | [optional] |
| **message_status** | **String** | The status of the message | [optional] |
| **message_direction** | **String** | The direction of the message relative to Bandwidth. INBOUND or OUTBOUND | [optional] |
| **message_type** | **String** | The type of message. sms or mms | [optional] |
| **segment_count** | **Integer** | The number of segments the message was sent as | [optional] |
| **error_code** | **Integer** | The numeric error code of the message | [optional] |
| **receive_time** | **String** | The ISO 8601 datetime of the message | [optional] |
| **carrier_name** | **String** | The name of the carrier. Not currently supported for MMS, coming soon | [optional] |
| **message_size** | **Integer** | The size of the message including message content and headers | [optional] |
| **message_length** | **Integer** | The length of the message content | [optional] |
| **attachment_count** | **Integer** | The number of attachments the message has | [optional] |
| **recipient_count** | **Integer** | The number of recipients the message has | [optional] |
| **campaign_class** | **String** | The campaign class of the message, if it has one | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::BandwidthMessageItem.new(
  message_id: 1589228074636lm4k2je7j7jklbn2,
  account_id: 12345,
  source_tn: +15554443333,
  destination_tn: +15554442222,
  message_status: DLR_EXPIRED,
  message_direction: OUTBOUND,
  message_type: sms,
  segment_count: 1,
  error_code: 9902,
  receive_time: 2020-04-07T14:03:07.000Z,
  carrier_name: other,
  message_size: 27,
  message_length: 18,
  attachment_count: 1,
  recipient_count: 1,
  campaign_class: T
)
```

