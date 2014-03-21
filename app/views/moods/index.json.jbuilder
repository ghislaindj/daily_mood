json.array! @moods do |mood|
  json.updated_at      mood.updated_at.strftime("%d/%m/%Y")
  json.value           mood.value
  json.human_value     mood.human_value
end