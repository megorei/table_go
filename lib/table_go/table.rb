module TableGo
  class Table

    attr_accessor :collection, :model_klass
    attr_accessor :columns

    def initialize(collection, model_klass, options, &block)
      @collection  = collection
      @model_klass = model_klass
      @columns     = []
      apply_options!(options)
      evaluate_dsl!(block)
    end

    def evaluate_dsl!(block)
      if block
        # instance_eval(&block)
        block.call(self)
      else
        TableGo::Orm.attribute_names_from_model_klass(model_klass).each do |column_name|
          column(column_name)
        end
      end
    end

    # def model_klass_reflection_keys
    #   @model_klass_reflection_keys ||= model_klass.reflections.keys
    # end

    def apply_options!(options)
      options.each { |k, v| send(k, v) }
    end



    def column(name, options = {}, &block)
      @columns << Column.new(self, name, options, &block)
    end

    def title(title = nil)
      @title = title if title
      @title
    end

    def table_html(table_html = nil)
      @table_html = table_html if table_html
      @table_html
    end

    def row_html(row_html = nil)
      @row_html = row_html if row_html
      @row_html
    end

    def render_rows_only(render_rows_only = nil)
      @render_rows_only = render_rows_only if render_rows_only
      @render_rows_only
    end

    def without_header(without_header = nil)
      @without_header = without_header if without_header
      @without_header
    end
  end
end