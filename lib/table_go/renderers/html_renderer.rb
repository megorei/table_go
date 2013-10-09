module TableGo
  module Renderers
    class HtmlRenderer
      include RendererBase

      def render_template
        content_tag(:table, table.table_html) do
          concat(content_tag(:caption, table.title)) if table.title
          concat(table_head)
          concat(table_body)
        end
      end

      def table_head
        content_tag(:thead) do
          content_tag(:tr) do
            table.columns.each do |column|
              concat(content_tag(:th, label_for_column(column), html_options_for_header(column)))
            end
          end
        end
      end

      def table_body
        content_tag(:tbody) do
          table.collection.each do |record|
             tr = content_tag(:tr, html_options_for_row(record)) do
              table.columns.each do |column|
                value = value_from_record_by_column(record, column)
                concat(content_tag(:td, apply_formatter(record, column, value), html_options_for_cell(record, column, value)))
              end
             end
             concat(tr)
          end
        end
      end

      def table_foot
        content_tag(:tfoot) do
          content_tag(:tr) do
          end
        end
      end
    end
  end
end