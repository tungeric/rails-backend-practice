# README
Welcome to an api for an ephemeral chat service! This is built using Ruby on Rails, largely because I have the most experience with this framework, but also because Ruby on Rails is designed for quick development due to its tendency for convention. This service should be able to accomodate 3 endpoints:

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
Once the repo is cloned, run `rails s` to run the server. You can then run the program against tests. Note that this application uses PostgreSQL, so make sure that is running as well.

## Decision making process

### POST `/chat`
The assignment dictates that the username and text of the chats are required, while the timeout is not but has a default value of 60. I implemented those validations at the server level. In the model level, I added validations for presence of username, text, and timeout (by the time it hits the model the default value for timeout will have already kicked in so it's more of a sanity check).

Once the model is created and validated, the next step is to get the Controller and View slices of the MVC architecture set up. 

The controller side is fairly straightforward for creating chats. It creates a new Chat item using `Chat.new` and giving it the input parameters. If the chat passes validations and is able to save, then it renders a json object containing the id and sets a status of 201. Otherwise it renders errors.

### GET `chat/:id`
This endpoint ends up being combined with the next one, but until it does, it is also fairly straightforward. It finds the Chat object using the `find_by` method and passing the id in, and renders the view in `show.json.jbuilder`. In the view, you extract the username and text columns for the chat object, but the expiration date needs to be defined. So in the model, I wrote an `expiration_date` method which returns the Time at which the chat was created added to the timeout of the chat. I added a separate function called `display_expiration_date` just to ensure the correct format of the Time. This is the value (a string) that is then displayed in the view.

### GET `chat/:username`
The first challenge here is to make sure the application can detect whether the user input an id or a username. My solution to do this is to convert the parameter to an integer, and if it is 0, this indicates that is is not an id (The id cannot possibly be 0, but strings converting to integers in Ruby become 0).

Now that that's done, we need to be able to extract all unexpired chats in our Chat model. To do this, I used ActiveRecord and SQL logic to first grab all chats that are directed at the user shown. These chats are then filtered by whether the expiration date of each chat (which I discussed in the previous section) is greater than the current Time.

Before we render these chats, we need to force the expiration of the chats that are found. To do this, we update the timeout of the chat to be the current Time subtracted by the Time the chat was created, which makes any future requests for the same username not return that chat again.

## Things I would improve upon
Having the application grab all chats for a specific user and then filtering through for unexpired chats can take more and more time as the database grows. I would think about adding a field that denotes whether a chat is expired or not, so querying the database for unexpired chats wouldn't require grabbing the entire table and then filtering from there.

There's probably a few validations that are missed. For example, if a username is all numbers, this would confuse the program as it would think it is searching for an id. I would add some sort of validation ensuring that the usernames are not pure numbers.

Last but not least, this application would be more complete if there were actual users and you could tie chats to user objects, as opposed to strings with usernames. This would also allow for authentication to be implemented in the application. 



