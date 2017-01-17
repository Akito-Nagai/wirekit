json.id           channel.uuid
json.name         channel.name
json.description  channel.description
json.created_at   channel.created_at
json.updated_at   channel.updated_at
json._links do
  json.self       { json.href v1_channel_url(channel) }
  json.attendees  { json.href v1_channel_attendees_url(channel) }
  json.messages   { json.href v1_channel_messages_url(channel) }
end
