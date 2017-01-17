json.id           lounge.uuid
json.name         lounge.name
json.description  lounge.description
json.created_at   lounge.created_at
json.updated_at   lounge.updated_at
json._links do
  json.self       { json.href v1_lounge_url(lounge) }
  json.attendees  { json.href v1_lounge_attendees_url(lounge) }
  json.channels   { json.href v1_lounge_channels_url(lounge) }
end
