module TableGo
  class Dsl
    include Enumerable
    attr_accessor :table

    def initialize(table)
      @table, @columns = table, []
    end

    def column(name, options = {}, &block)
      @columns << Column.new(table, name, options, &block)
    end

    def each(&block)
      @columns.each(&block)
    end

    def title(title)

    end

  end
end