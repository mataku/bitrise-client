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

client = Bitrise::Client.new
client.trigger_build(
  app_slug = 'your_app_slug', # Required
  access_token = 'your_access_token', # Required. See: https://devcenter.bitrise.io/en/api/authenticating-with-the-bitrise-api.html
  build_params: {
    # A tag, branch or workflow_id parameter required
    branch: 'branch',
    tag:    'tag',
    workflow_id: 'workflow_id'
  }
)
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
