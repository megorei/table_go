module TableGo
  class Orm
    class << self
      def attribute_names_from_model_klass(model_class)
        if defined?(Neo4j) && model_class.ancestors.include?(Neo4j::ActiveNode)
          model_class.attribute_names
        else
          model_class.respond_to?(:column_names) ? model_class.column_names : []
        end
      end

      def human_attribute_name(model_class, name)
        if model_class.respond_to?(:human_attribute_name) # using rails default I18n
          model_class.human_attribute_name(name).html_safe
        end
      end
    end
  end
end