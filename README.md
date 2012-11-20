# Whisper
=============

Whisper allows you to chat with users within an existing application.


## Requirements

This gem uses Pusher for realtime messages and Devise for user authentication.
Please see http://www.pusher.com and create an account (it is free).

## Installation for Rails 3.1 and above

Add the gem to your Gemfile

``` ruby
gem 'whisper', '0.1.0'
```

save and run bundle install.

Then run the installer

``` ruby
rails g whisper:install
```

## Configuration into your rails application

In application.js add the following (I personally use coffescript)

``` javascript
//= require whisper/pusher.min
//= require whisper/whisper
//= require whisper/chat
```

In application.css add the following (I use sass notation here)

``` sass
@import "whisper/whisper"
```

Insert this javascript snippet to trigger the chat

``` javascript
javascript: chatWith("username");
```
