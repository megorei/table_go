require 'fastercsv'
module TableGo
  module Renderers
    class CsvRenderer
      include RendererBase

      def render_template
        ::FasterCSV.generate(:col_sep => ";", :row_sep => "\n", :force_quotes => true, :quote_char => '"') do |csv|
          csv << source_table.columns.map { |column| label_for_column(column) }
          source_table.collection.each do |record|
            csv << source_table.columns.map do |column|
              value = value_from_record_by_column(record, column)
              apply_formatter(record, column, value)
            end
          end
        end
      end

    end
  end
end