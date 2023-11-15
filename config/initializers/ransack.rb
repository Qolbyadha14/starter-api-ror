Ransack.configure do |c|
  # Change default search parameter key name.
  # Default key name is :q
  c.search_key = :query
  c.strip_whitespace = false
  c.ignore_unknown_conditions = false
  c.hide_sort_order_indicators = true

end
