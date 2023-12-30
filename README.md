# Music Album Quiz Generator #

## About ##

Test your knowledge of album covers on Spotify by creating an account, making quizzes and trying out other people's quizzes!

## Contributors ## 

Evan Tao 

## Dependencies ## 

- `bundler 2.5.3`
- `ruby 3.3.0`
- `rails 7.2.1`

## Testing ## 

1. First, run `bundle install` to install all relevant gems. 
2. Then, run `rails s` to start the web application. 

## Models ##
- Users
- Albums
- Tests
- Albums_Tests

## Associations ##

- User has_many Tests
- Albums has_many Tests

## Features ##

- Add/Remove albums from Tests - Nested Resources
- Sessions and BCrypt Passwords - Log In/Out
- Spotify Validations
- Image Embed
- Radio Buttons
- Answer Checking
- High Scores