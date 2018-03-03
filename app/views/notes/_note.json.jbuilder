json.extract! note, :id, :title, :content, :rate, :memo, :created_at, :updated_at
json.url note_url(note, format: :json)
