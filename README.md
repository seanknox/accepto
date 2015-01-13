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
