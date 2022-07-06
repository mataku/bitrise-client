## v0.3.1

Add GET apps. - [@tomorrowkey](https://github.com/tomorrowkey) [#6](https://github.com/mataku/bitrise-client/pull/6)

## v0.3.0

Lock faraday version to 1.X because `Faraday::Response::Middleware` is deleted in faraday 2. - [@tomorrowkey](https://github.com/tomorrowkey) [#5](https://github.com/mataku/bitrise-client/pull/5) 

## v0.2.0

Changed to use the [Bitrise v0.1 API](https://devcenter.bitrise.io/en/api.html), so you need to change to specify an access token to bitrise-client initialization. See: https://github.com/mataku/bitrise-client#usage

- Support endpoint for triggering a build
- Support aborting a build
- Support listing registered test devices of all members of a specified Bitrise app

## v0.1.0

Released.

- Support triggering a build
