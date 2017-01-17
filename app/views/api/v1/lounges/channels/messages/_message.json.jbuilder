json.id           message.uuid
json.body         message.body
json.description  message.description
json.created_at   message.created_at
json.updated_at   message.updated_at
json.deleted_at   message.deleted_at
json.edited_at    message.edited_at
json.attendee do
end
json._links do
  json.self       { json.href v1_message_url(message) }
end
