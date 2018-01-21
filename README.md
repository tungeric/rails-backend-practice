# README
Welcome to an api for an ephemeral chat service! This service should be able to accomodate 3 endpoints:

1. POST `/chat`
  * Creates a new chat with username, text body, and a timeout which is the amount of time in seconds before the chat expires
  * Returns a success status code of 201: Created
  * Returns a body with the id of the created chat, i.e. `{ "id": 5488 }`

2. GET `/chat/:id`
  * Gets the chat corresponding to the id
  * Returns a success status code of 200: OK
  * Returns the body with username, text, and expiration date (not the timeout!)
```ruby
{
  "username": "paulrad",
  "text": "This is a message",
  "expiration_date": "2015-08-12 06:22:52"
}
```

3. GET `/chat/:username`
  * Gets all unexpired chats that are sent to the specified username
  * Returns a success status code of 200: OK
  * Returns a body of an array of unexpired chats with the id and text
```ruby
[
  {
    "id": 95958,
    "text": "This is a message"
  },
  {
    "id": 95959,
    "text": "This is also a message"
  },
]
```
  * Once chats are opened using this endpoint, they are immediately expired and cannot be accessed with this endpoint again.


## How to use
Once the repo is cloned, run `rails s` to run the server. You can then run the program against tests.

## Decision making process

### POST `/chat`

