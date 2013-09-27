module TableGo
  class Table

    attr_accessor :collection, :model_klass
    attr_accessor :columns

    def initialize(collection, model_klass, &block)
      @collection  = collection
      @model_klass = model_klass
      @columns     = []
      evaluate_dsl(block)
    end

    def evaluate_dsl(block)
      if block
        instance_eval(&block)
      else
        attribute_names_from_model_klass.each do |column_name|
          column(column_name)
        end
      end
    end

    # def model_klass_reflection_keys
    #   @model_klass_reflection_keys ||= model_klass.reflections.keys
    # end

    def attribute_names_from_model_klass
      model_klass.respond_to?(:column_names) ? model_klass.column_names : []
    end



    def column(name, options = {}, &block)
      @columns << Column.new(self, name, options, &block)
    end

    def title(title)

    end


  end
end