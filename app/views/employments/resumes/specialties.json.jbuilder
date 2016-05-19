json.array! @specialties do |s|
  json.id s.esp_code
  json.text s.esp_name
end
