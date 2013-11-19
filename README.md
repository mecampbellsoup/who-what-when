#who-what-when

Who-What-When is a Rails application that lets you draft text messages and send them at a later date. Our inspiration is [Gmail's Boomerang plugin](http://www.boomeranggmail.com/).

##Usage
1. Visit http://bit.ly/textmelater
2. Enter the "who" (recipient phone number)
3. Enter the "what" (message body)
4. Enter the "when" (when you want to receive a reminder containing the "what" to be sent to the "who")

##Technology
- Twilio API
- Rails 4.0
- Ruby 2.0

##Run locally
1. Download the most recent branch and ```bundle install```
2. Make sure you have redis installed: ```brew install redis```
3. Open three terminal windows in the root of the rails app, and execute the following commands, each in a seperate window, in the following order: 

		$  redis-server /usr/local/etc/redis.conf
		$  bundle exec sidekiq
		$  rails server

##Contributing
If you'd like to hack on this, start by forking the repo on GitHub:

[](https://github.com/mecampbellsoup/who-what-when)

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `rake`
1. If you are adding new functionality, document it in the README
1. Do not change the version number, we will do that on our end
1. Push the branch up to GitHub
1. Send a pull request for your branch

Built with ♥ <a href="https://twitter.com/flatironschool">@flatironschool</a>