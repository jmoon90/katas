def location(item, value)
  sub_table = get_sub_table(item, value)
  assert_sub_table_has_value(item, value, sub_table)
  first_row = sub_table[0]

  metric_location_library = { :class => MetricFu::Location.get(first_row.file_path, first_row.class_name, nil),
                              :method => MetricFu::Location.get(first_row.file_path, first_row.class_name, first_row.method_name),
                              :file => MetricFu::Location.get( first_row.file_path, nil, nil) }
  metric_location_library.fetch(item) do
    raise ArgumentError, "Item must be :class, :method, or :file"
  end
end

def assert_sub_table_has_value(item, value, sub_table)
  raise MetricFu::AnalysisError, "the #{item.to_s} '#{value.to_s}'￼"\ "does not have any rows in the analysis table" if(sub_table.length==0)
end
