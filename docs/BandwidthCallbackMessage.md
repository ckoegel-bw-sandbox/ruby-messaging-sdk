# OpenapiClient::BandwidthCallbackMessage

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **time** | **String** |  | [optional] |
| **type** | **String** |  | [optional] |
| **to** | **String** |  | [optional] |
| **error_code** | **String** |  | [optional] |
| **description** | **String** |  | [optional] |
| **message** | [**BandwidthMessage**](BandwidthMessage.md) |  | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::BandwidthCallbackMessage.new(
  time: null,
  type: null,
  to: null,
  error_code: null,
  description: null,
  message: null
)
```

