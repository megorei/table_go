module TableGo
  class Table

    attr_accessor :collection, :model_klass, :columns

    def initialize(collection, model_klass, *template_args, &block)
      @collection  = collection
      @model_klass = model_klass
      @columns     = Columns.new
      evaluate_dsl(block)

      @template = StandardTemplate.new(*template_args)
      @template.source_table = self
    end

    def evaluate_dsl(block)
      if block
        block.call(@columns)
      else
        model_klass.column_names.each do |column_name|
          @columns.column(column_name)
        end
      end
    end

    def render(options)
      @template._render(options)
    end

    def model_klass_reflection_keys
      @model_klass_reflection_keys ||= model_klass.reflections.keys
    end

  end
end