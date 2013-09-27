module TableGo
  class TableRenderer
    attr_accessor :renderer_klass, :template
    delegate      :render_template, :to => :renderer

    def initialize(table)
      @table = table
    end

    def renderer
      @renderer ||= renderer_klass.new.tap do |r|
        r.template  = template
        r.table     = @table
      end
    end

  end
end

