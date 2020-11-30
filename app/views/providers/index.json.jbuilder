json.array! @provider do |provider|
  json.id provider.id
  json.provder_name provider.html_safe
  json.name provider.name
end