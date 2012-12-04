module TableGo
  class TableRenderer
    attr_accessor :renderer_klass, :template
    delegate      :apply_options, :render_template, :to => :renderer

    def initialize(source_table)
      @source_table = source_table
    end

    def renderer
      @renderer ||= renderer_klass.new.tap do |r|
        r.template     = template
        r.source_table = @source_table
      end
    end

  end
end

