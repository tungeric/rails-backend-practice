@chats.each do |chat|
  json.set! chat.id do
    json.partial! "chats/chat", chat: chat
  end
end
