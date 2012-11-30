module TableGo
  class Column
    attr_accessor :table, :name, :options, :block

    def initialize(table, name, options = {}, &block)
      @table, @name, @options, @block = table, name, options, block
    end

    def label
      options[:label]
    end

    def as
      options[:as]
    end

    def as_options
      options[:as_options] || {}
    end

    def header_html
      options[:header_html]
    end

    def column_html
      options[:column_html]
    end

    def method
      options[:method]
    end

    def human_attribute_name
      if table.model_klass.respond_to?(:human_attribute_name)
        table.model_klass.human_attribute_name(name).html_safe
      else
        name.to_s.humanize
      end
    end

  end
end