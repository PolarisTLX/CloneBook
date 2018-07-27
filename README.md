# README

## Check it out live on Heroku:    [clonebook-microverse.herokuapp.com](https://clonebook-microverse.herokuapp.com)

## Fully-featured social media app built with Ruby on Rails from scratch.
* Social media site for content sharing: Users can sign up securely, create a profile, add friends, post, comment, and like other content.
* Uses Devise and Omniauth for user registration.
* Implements photo uploading with Paperclip.
* Deployed on Heroku and uses AWS S3 for photo storage.
* Tested with RSpec.


## Getting started (to run a local copy)


* System dependencies

Ruby version: 2.3.1
Rails version: 5.2.0
Bundler version: 1.16.1


To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally run the app in a local server:

```
$ rails server
```

Open your browser at "localhost:3000".


To run the RSpec test suite, first run:

```
$ rails db:seed ENV=test
```

Then run:

```
$ rspec
```

## Authors

* **Kyle Lemon** - [jklemon17](https://github.com/jklemon17)
* **Paul Rail** - [PolarisTLX](https://github.com/PolarisTLX)
