require 'fastercsv'
module TableGo
  module Renderers
    class CsvRenderer
      include RendererBase

      def render_template
        ::FasterCSV.generate(:col_sep => ";", :row_sep => "\n", :force_quotes => true, :quote_char => '"') do |csv|
          csv << table.columns.map { |column| label_for_column(column) } unless table.render_rows_only
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