require 'axlsx'

module TableGo
  module Renderers
    class XlsxRenderer
      include RendererBase

      def render_template
        package = ::Axlsx::Package.new
        package.workbook do |workbook|
          # workbook.add_worksheet(:name => table.model_klass.to_s.gsub(/[\[\]\*\/\?\:]/, ' ')[0..30]) do |sheet|
          workbook.add_worksheet(:name => 'test') do |sheet|
            sheet.add_row(['test 1', 'test 2'])
            # unless table.render_rows_only || table.without_header
              # sheet.add_row(table.columns.map { |column| label_for_column(column) })
            # end
            # table.collection.each do |record|
            #   sheet.add_row(
            #     table.columns.map do |column|
            #       value = value_from_record_by_column(record, column)
            #       apply_formatter(record, column, value)
            #     end
            #   )
            # end
          end
        end

        package.to_stream.string
      end

    end
  end
end