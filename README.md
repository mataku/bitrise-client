# Bitrise::Client

A ruby client for [Bitrise API](https://devcenter.bitrise.io/#bitrise-api).

Now supports v0.1 [Build Trigger API](https://devcenter.bitrise.io/api/build-trigger/) only.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitrise-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitrise-client

## Usage

```ruby
require 'bitrise'

# Access token required to use bitrise v0.1 API. See: https://devcenter.bitrise.io/en/api/authenticating-with-the-bitrise-api.html
client = Bitrise::Client.new(access_token: 'your access token')

# Trigger a build
result = client.trigger_build(
  app_slug: 'your_app_slug', # Required
  build_params: {
    # At least a tag, branch or workflow_id parameter required so that Bitrise can identify which workflow to run
    branch: 'branch',
    tag:    'tag',
    workflow_id: 'workflow_id'
  }
)

p result.build_url # => "https://app.bitrise.io/build/1234abcd5678efgh"

# Abort a build
client.abort_build(
  # Required
  app_slug: 'your_app_slug',
  # Required
  build_slug: 'build slug to abort',

  # Optional
  options: {
    abort_reason: 'wanna relax', # You can set a reason
    abort_with_success: true,    # Set true if you want to treat as a successful
    skip_notifications: true     # Set true if you want to receive notification even if your notification setting in app is off
  }
)
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
