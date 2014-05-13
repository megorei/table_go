require 'csv'
if CSV.const_defined?(:Reader)
  require 'fastercsv'
  Object.send(:remove_const, :CSV)
  ::CSV = ::FasterCSV
end

module TableGo
  module Renderers
    class CsvRenderer
      include RendererBase

      def render_template
        ::CSV.generate(:col_sep => ";", :row_sep => "\n", :force_quotes => true, :quote_char => '"') do |csv|
          csv << table.columns.map { |column| label_for_column(column) } unless table.render_rows_only || table.without_header
          table.collection.each do |record|
            csv << table.columns.map do |column|
              value = value_from_record_by_column(record, column)
              apply_formatter(record, column, value)
            end
          end
        end
      end

    end
  end
end