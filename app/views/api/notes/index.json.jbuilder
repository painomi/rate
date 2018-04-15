json.set! :notes do
    json.array! @notes do |note|
      json.extract! note, :id, :rate, :memo, :created_at, :updated_at
    end
end
