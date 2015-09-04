json.journals do
  json.array!(@journals) do |journal|
    json.extract! journal, :id, :event, :created_at, :description
  end
end

json.partial! 'api/shared/pagination', collection: @journals