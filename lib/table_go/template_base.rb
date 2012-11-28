module TableGo
  class TemplateBase < Minimal::Template

    attr_accessor :source_table

    def title
      locals[:title]
    end

    def table_html
      locals[:table_html]
    end

    def row_html
      locals[:row_html]
    end

    def content
      render_table
    end

    def label_for_column(column)
      column.label || begin
        if column.method && reflection = source_table.model_klass.reflections[column.name]
          reflection.klass.human_attribute_name(column.method).html_safe
        else
          source_table.model_klass.human_attribute_name(column.name).html_safe
        end
      end
    end

    def html_options_for_header(column)
      {}.tap do |h|
        (column.header_html || {}).each do |k, v|
          h[k] = v.is_a?(Proc) ? v.call(column) : v
        end
      end
    end

    def html_options_for_row(record)
      {}.tap do |h|
        (row_html || {}).each do |k, v|
          h[k] = v.is_a?(Proc) ? v.call(record) : v
        end
      end
    end

    def html_options_for_cell(record, column, value)
      {}.tap do |h|
        (column.column_html || {}).each do |k, v|
          h[k] = v.is_a?(Proc) ? v.call(record, column, value) : v
        end
      end
    end

    # def render_record(record, column)
    #   apply_formatter(record, column, value_from_record_by_column(record, column))
    # end

    def value_from_record_by_column(record, column)
      value = record.send(column.name)
      column.method ? value.send(column.method) : value
    end


    def apply_formatter(record, column, value)
      if formatter = column.as
        Formatter.apply(formatter, record, column, value)
      elsif formatter = column.block
        capture { Formatter.apply(formatter, record, column, value) }
      else
        value
      end
    end

  end
end