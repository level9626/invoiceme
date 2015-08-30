json.pagination do
  json.total_pages   collection.total_pages
  json.current_page  collection.current_page
  json.total_entries collection.total_entries
  json.previous_page collection.previous_page
  json.next_page     collection.next_page
end