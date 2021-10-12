# OpenapiClient::BandwidthMessagesList

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **total_count** | **Integer** | Total number of messages matched by the search | [optional] |
| **page_info** | [**PageInfo**](PageInfo.md) |  | [optional] |
| **messages** | [**Array&lt;BandwidthMessageItem&gt;**](BandwidthMessageItem.md) |  | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::BandwidthMessagesList.new(
  total_count: 100,
  page_info: null,
  messages: null
)
```

