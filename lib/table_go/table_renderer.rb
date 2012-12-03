module TableGo

  class TableRenderer

    def initialize(template_args, source_table, renderer_klass)
      @renderer = renderer_klass.new(template_args)
      @renderer.source_table = source_table
    end

    def render(options = {})
      @renderer.render_template(options)
    end

  end
end

