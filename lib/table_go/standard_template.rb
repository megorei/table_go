module TableGo
  class StandardTemplate < TemplateBase

    def render_table
      table table_html do
        caption title if title
        render_table_head
        render_table_body
        # render_table_foot
      end
    end

    def render_table_head
      thead do
        tr do
          source_table.columns.each do |column|
            td label_for_column(column), html_options_for_header(column)
          end
        end
      end
    end

    def render_table_body
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

    def render_table_foot
      tfoot do
        tr do
        end
      end
    end

  end
end