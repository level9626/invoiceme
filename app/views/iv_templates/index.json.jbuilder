json.array!(@iv_templates) do |iv_template|
  json.extract! iv_template, :id, :name
  json.url iv_template_url(iv_template, format: :json)
end
