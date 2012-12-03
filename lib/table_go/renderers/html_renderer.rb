module TableGo
  module Renderers
    class HtmlRenderer < Minimal::Template
      include RendererBase

      def render_template(options)
        self.title      = options.delete(:title)
        self.table_html = options.delete(:table_html)
        self.row_html   = options.delete(:row_html)
        _render(options)
      end

      def content
        table table_html do
          caption title if title
          table_head
          table_body
          # table_foot
        end
      end

      def table_head
        thead do
          tr do
            source_table.columns.each do |column|
              th label_for_column(column), html_options_for_header(column)
            end
          end
        end
      end

      def table_body
        tbody do
          source_table.collection.each do |record|
            tr html_options_for_row(record) do
              source_table.columns.each do |column|
                value = value_from_record_by_column(record, column)
                td apply_formatter(record, column, value), html_options_for_cell(record, column, value)
              end
            end
          end
        end
      end

      def table_foot
        tfoot do
          tr do
          end
        end
      end

    end
  end
end