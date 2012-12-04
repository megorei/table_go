module TableGo
  module Renderers
    class HtmlRenderer
      include RendererBase

      def render_template
        Template.new(template)._render(:renderer => self)
      end



      class Template < Minimal::Template
        def renderer
          locals[:renderer]
        end

        def content
          table renderer.table_html do
            caption renderer.title if renderer.title
            table_head
            table_body
            # table_foot
          end
        end

        def table_head
          thead do
            tr do
              renderer.source_table.columns.each do |column|
                th renderer.label_for_column(column), renderer.html_options_for_header(column)
              end
            end
          end
        end

        def table_body
          tbody do
            renderer.source_table.collection.each do |record|
              tr renderer.html_options_for_row(record) do
                renderer.source_table.columns.each do |column|
                  value = renderer.value_from_record_by_column(record, column)
                  td renderer.apply_formatter(record, column, value), renderer.html_options_for_cell(record, column, value)
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
end