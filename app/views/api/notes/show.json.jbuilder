json.set! :note do
    json.extract! @note, :id, :rate, :memo, :created_at, :updated_at
end