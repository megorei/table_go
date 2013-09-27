module TableGo
  module Renderers
    module RendererBase
      extend ActiveSupport::Concern

      included do
        attr_accessor :source_table, :title, :table_html, :row_html, :template
        delegate :content_tag, :concat, :to => :template
      end


      def apply_options(options)
        self.title      = options.delete(:title)
        self.table_html = options.delete(:table_html)
        self.row_html   = options.delete(:row_html)
      end

      def render_template
        raise ArgumentError.new('implement #render_template in concrete renderer')
      end



      private

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

        def value_from_record_by_column(record, column)
          if record.respond_to?(column.name)
            value = record.send(column.name)
            column.method ? value.send(column.method) : value
          else
            ''
          end
        end

        def apply_formatter(record, column, value)
          case
            when formatter = column.as
              Formatter.apply(formatter, record, column, value)
            when formatter = column.send
              Formatter.apply_send(formatter, record, column, value)
            when formatter = column.block
              apply_formatter_for_block(formatter, record, column, value)
            else
              value
          end
        end



        def apply_formatter_for_block(formatter, record, column, value)
          s = nil
          capture_view do
            s = Formatter.apply(formatter, record, column, value )
          end.presence || s # for compatibility to legacy haml "- t.column :ident"
        end

        def capture_view(&proc)
          @capturer ||= template.is_haml? ? capture_haml : capture_action_view
          @capturer.call(proc)
        end

        def capture_haml(&proc)
          lambda { |c| template.capture_haml { c.call } }
        end

        def capture_action_view
          lambda { |c| template.capture { c.call } }
        end

    end
  end
end