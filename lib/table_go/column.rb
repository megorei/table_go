module TableGo
  class Column
    attr_accessor :name, :options, :block

    def initialize(name, options = {}, &block)
      @name, @options, @block = name, options, block
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

  end
end