json._links do
  json.stream { json.href v1_stream_url }
  json.lounges { json.href v1_lounges_url }
end
