json.array! @moods do |mood|
  json.updated_at      mood.updated_at.strftime("%d/%m/%Y")
  json.created_at      mood.created_at.strftime("%d/%m/%Y")
  json.value           mood.value
  json.human_name      mood.human_name
end