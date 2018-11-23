# What

Web-based UI (and React components library) that serve as clients for various interactions against MatterMost server. 
MatterMost official Web UI is used as base for this code. That UI is taken apart into individual components that can be
meaningfully embedded into other pages / sites.

# Why

MatterMost stand-alone client is a good stand-alone client, but we don't need a client. We need embeddable components.

Here we take the official client apart into components that together still act as effective MatterMost client, but can
be embedded independently throughout the page to facilitate better, natural user experience for users leveraging
real-time communication within some other product.

# How

Read https://developers.mattermost.com/contribute/webapp/developer-setup/

- run `npm run build` (creates / updates `./dist` folder)
- run `make start-stack` (uses `./dist` folder contents to serve UI)
- (in a separate terminal) run `make scaffold` to set up base users (including usernames and passwords), team etc. 
- navigate to [localhost:8080](http://localhost:8080) 
- can stop compose stack with CTRL+C
- run `make stop-stack` if some processes are stuck after CTRL+C. Check with `docker ps`

This set up saves the state of the server in `.volumes` folder. 
First time you start the stack, `.volumes` folder will be auto-created.
Inspect the folder after first run to see messaging server settings, logs, meda-data.

# Original README Contents

Mattermost is an open source, self-hosted Slack-alternative from [https://mattermost.org](https://mattermost.org).

It's written in Golang and React and runs as a single Linux binary with MySQL or Postgres. Every month on the 16th [a new compiled version is released under an MIT license](https://www.mattermost.org/download/).

This project hosts the webapp client code. Please file issues at [/mattermost-server](https://github.com/mattermost/mattermost-server), which hosts the server code.

- [Review product documentation](http://docs.mattermost.com/).
- [Review developer documentation](https://developers.mattermost.com/).
- [Download compiled version](https://mattermost.org/download).

Try out Mattermost: 

- [Join the Mattermost Contributor's server](https://pre-release.mattermost.com/) (latest nightly builds, unstable)
- [Join the Mattermost Demo server](https://demo.mattermost.com) (latest stable version)

Deploy on Heroku 

[![Deploy a Preview](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mattermost/mattermost-heroku)

_Note: Heroku preview does not include email or persistent storage_

Install on your own machine: 

- [One-line Docker Preview](http://docs.mattermost.com/install/docker-local-machine.html#one-line-docker-install) 
- [Developer Machine Setup](https://docs.mattermost.com/developer/dev-setup.html)
- [Production Install Guides using Linux Binary](http://www.mattermost.org/installation/)
- [Production Docker Install](https://docs.mattermost.com/install/prod-docker.html) 

Get Involved:

- [Contribute Code](http://docs.mattermost.com/developer/contribution-guide.html)
- [Find "Help Wanted" projects](https://mattermost.atlassian.net/issues/?filter=10101)
- [Join Developer Discussion on a Mattermost Server for contributors](https://pre-release.mattermost.com/signup_user_complete/?id=f1924a8db44ff3bb41c96424cdc20676)
- [File Bugs](http://www.mattermost.org/filing-issues/)
- [Share Feature Ideas](http://www.mattermost.org/feature-requests/)
- [Get Troubleshooting Help](https://forum.mattermost.org/t/how-to-use-the-troubleshooting-forum/150)

Learn More:

- [API Options - webhooks, slash commands, drivers and web service](http://docs.mattermost.com/developer/api.html)
- [Localization Guide](http://docs.mattermost.com/developer/localization.html#translation-process)

Get the Latest News:

- **Twitter** - Follow [MattermostHQ](https://twitter.com/mattermosthq)
- **Email** - Subscribe to our [newsletter](http://mattermost.us11.list-manage.com/subscribe?u=6cdba22349ae374e188e7ab8e&id=2add1c8034) (1 or 2 per month)
- **IRC** - Join us on #matterbridge (thanks to [matterircd](https://github.com/42wim/matterircd))

Any other questions, mail us at info@mattermost.com. We'd love to meet you!
