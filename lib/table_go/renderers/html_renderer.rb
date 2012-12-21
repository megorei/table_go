module TableGo
  module Renderers
    class HtmlRenderer
      include RendererBase

      def render_template
        template.content_tag :table, table_html do
          template.concat template.content_tag(:caption, title) if title
          template.concat table_head
          template.concat table_body
        end
      end

      def table_head
        template.content_tag :thead do
          template.content_tag(:tr) do
            source_table.columns.each do |column|
              template.concat template.content_tag(:th, label_for_column(column), html_options_for_header(column))
            end
          end
        end

      end

      def table_body
        template.content_tag :tbody do

          source_table.collection.each do |record|
             tr = template.content_tag(:tr, html_options_for_row(record)) do
              source_table.columns.each do |column|
                value = value_from_record_by_column(record, column)
                template.concat template.content_tag(:td, apply_formatter(record, column, value), html_options_for_cell(record, column, value))
              end
             end
             template.concat tr
          end
        end
      end

      def table_foot
        template.content_tag :tfoot do
          template.content_tag :tr do
          end
        end
      end
    end
  end
end