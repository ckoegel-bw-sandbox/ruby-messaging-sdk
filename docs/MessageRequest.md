# OpenapiClient::MessageRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **application_id** | **String** | The ID of the Application your from number is associated with in the Bandwidth Phone Number Dashboard. |  |
| **to** | **Array&lt;String&gt;** | The phone number(s) the message should be sent to in E164 format |  |
| **from** | **String** | One of your telephone numbers the message should come from in E164 format |  |
| **text** | **String** | The contents of the text message. Must be 2048 characters or less. | [optional] |
| **media** | **Array&lt;String&gt;** | A list of URLs to include as media attachments as part of the message. | [optional] |
| **tag** | **String** | A custom string that will be included in callback events of the message. Max 1024 characters | [optional] |
| **priority** | **String** | The message&#39;s priority, currently for toll-free or short code SMS only. Messages with a priority value of &#x60;\&quot;high\&quot;&#x60; are given preference over your other traffic. | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::MessageRequest.new(
  application_id: 93de2206-9669-4e07-948d-329f4b722ee2,
  to: [&quot;+15554443333&quot;,&quot;+15552223333&quot;],
  from: +15551113333,
  text: Hello world,
  media: [&quot;https://dev.bandwidth.com/images/bandwidth-logo.png&quot;,&quot;https://dev.bandwidth.com/images/github_logo.png&quot;],
  tag: custom string,
  priority: default
)
```

