module TableGo
  class Columns
    include Enumerable

    def initialize
      @columns = []
    end

    def column(name, options = {}, &block)
      @columns << Column.new(name, options, &block)
    end

    def each(&block)
      @columns.each(&block)
    end

  end
end