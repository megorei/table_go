module TableGo
  module Renderers
    module RendererBase
      extend ActiveSupport::Concern

      included do
        attr_accessor :source_table, :title, :table_html, :row_html, :template
      end

      def apply_options(options)
        self.title      = options.delete(:title)
        self.table_html = options.delete(:table_html)
        self.row_html   = options.delete(:row_html)
      end

      def render_template
        raise ArgumentError.new('implement #render_template in concrete renderer')
      end


      def label_for_column(column)
        column.label || begin
          if column.method && 1==3# reflection = source_table.model_klass.reflections[column.name]
            reflection.klass.human_attribute_name(column.method).html_safe
          # if column.method && reflection = source_table.model_klass.reflections[column.name]
          #   reflection.klass.human_attribute_name(column.method).html_safe
          else
            column.human_attribute_name
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
        elsif formatter = column.send
          Formatter.apply_send(formatter, record, column, value)
        elsif formatter = column.block
          capture { Formatter.apply(formatter, record, column, value) }
        else
          value
        end
      end

    end
  end
end