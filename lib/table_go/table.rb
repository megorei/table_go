module TableGo
  class Table

    attr_accessor :collection, :model_klass, :columns

    def initialize(collection, model_klass, &block)
      @collection  = collection
      @model_klass = model_klass
      @columns     = Columns.new(self)
      evaluate_dsl(block)
    end

    def evaluate_dsl(block)
      if block
        block.call(@columns)
      else
        attribute_names_from_model_klass.each do |column_name|
          @columns.column(column_name)
        end
      end
    end

    def model_klass_reflection_keys
      @model_klass_reflection_keys ||= model_klass.reflections.keys
    end

    def attribute_names_from_model_klass
      model_klass.respond_to?(:column_names) ? model_klass.column_names : []
    end

  end
end