json.array!(@term_sheets) do |term_sheet|
  json.extract! term_sheet, :id
  json.url term_sheet_url(term_sheet, format: :json)
end
