json.array!(@chats) do |chat|
  json.id chat.id
  json.text chat.text
end