json.id           attendee.uuid
json.name         attendee.name
json.url          attendee.url
json.status       attendee.status
json.created_at   attendee.created_at
json.updated_at   attendee.updated_at
json._links do
  json.self       { json.href v1_attendee_url(attendee) }
end
