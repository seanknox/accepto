[![Code Climate](https://codeclimate.com/repos/54b5734c6956801129003a1b/badges/a6061f161ef777b9a6a1/gpa.svg)](https://codeclimate.com/repos/54b5734c6956801129003a1b/feed) [![Test Coverage](https://codeclimate.com/repos/54b5734c6956801129003a1b/badges/a6061f161ef777b9a6a1/coverage.svg)](https://codeclimate.com/repos/54b5734c6956801129003a1b/feed)

# Acceptance App Manager
Acceptance App Manager creates new Heroku applications for GitHub branches using the App Setup resource of the [Heroku Platform API] and GitHub webhooks for a [Pull Request Event].

### How does it work?
Whenever a pull request event is triggered from GitHub, the acceptance app manager gets notified. Based on the event, it creates (or updates or destroys) a Heroku app reflecting the code in the pull request, and comments on the pull request with a URL to the Heroku app generated. While the pull request is open, this URL is live and can be accessed by your QA/Acceptance team for review!

### How can I set it up for my app?

- Add an [app.json] to your application's directory. While all fields are optional, you might find it helpful to specify postdeploy tasks and add-ons the application requires.

- Push this code to a Heroku application (such as `your-app-name-acceptance-app-manager`) and set up the environment variables `GITHUB_PERSONAL_TOKEN`, `GITHUB_PROJECT`, `GITHUB_USERNAME`, `HEROKU_API_KEY`, and `HEROKU_APP_PREFIX`.
- Set up the Pull Request webhook for your application in GitHub, giving it a Payload URL with `/hooks` as the endpoint, e.g. `https://your-app-name-acceptance-app-manager.herokuapp.com/hooks`.

[app.json]: https://devcenter.heroku.com/articles/app-json-schema#example-app-json
[Heroku Platform API]: https://devcenter.heroku.com/articles/setting-up-apps-using-the-heroku-platform-api
[Pull Request Event]: https://developer.github.com/v3/activity/events/types/#pullrequestevent

## For Future Development

### Get info on the create build you just submitted
* From in AcceptanceAppManager::Heroku instance
 * Call create and save the result `result = client.app_setup.create(data)`

 ```
result => {"id"=>"183b1019-6cbe-46d7-ac10-f5292e04dc4d",
 "failure_message"=>nil,
 "status"=>"pending",
 "app"=>{"id"=>"cf407c41-9fac-40e5-9e79-e69614f7dfbf", "name"=>"iris-acceptance-pr-85"},
 "build"=>{"id"=>nil, "status"=>nil},
 "manifest_errors"=>[],
 "postdeploy"=>{"output"=>nil, "exit_code"=>nil},
 "resolved_success_url"=>nil,
 "created_at"=>"2015-02-06T22:04:50+00:00",
 "updated_at"=>"2015-02-06T22:04:50+00:00"}
 ```

 * Get the `setup_id` from the result: `setup_id = result.fetch('id')`
 * Periodically call `info` with the `setup_id` until the `"status"` is ether `failed` or `successful` `info = client.app_setup.info(setup_id)`

 ```
  {"id"=>"183b1019-6cbe-46d7-ac10-f5292e04dc4d",
 "failure_message"=>"postdeploy exit code was not 0",
 "status"=>"failed",
 "app"=>{"id"=>"cf407c41-9fac-40e5-9e79-e69614f7dfbf", "name"=>"iris-acceptance-pr-85"},
 "build"=>{"id"=>"c5073d4a-186d-4e09-8f80-53de52dc0135", "status"=>"succeeded"},
 "manifest_errors"=>[],
 "postdeploy"=>
  {"output"=> ............
 ```

 ```ruby
switch info.fetch('status')
case 'pending'
  # continue checking for some set amount of time
case 'successful'
  # check the post_deploy (see below)
default
  # Notify github of failure
end
 ```

 * If successful, check postdeploy for a non-zero exit code

 ```ruby
 info.fetch('postdeploy').fetch('exit_code')
 ```

 * If exit code != 0, notify github with postdeploy output

 ```ruby
 message = info.fetch('postdeploy').fetch('output')
 ```
