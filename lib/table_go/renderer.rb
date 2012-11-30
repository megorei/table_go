module TableGo
  class Renderer

    def initialize(template_args, source_table)
      @template = StandardTemplate.new(template_args)
      @template.source_table = source_table
    end

    def render(options = {})
      @template.render_template(options)
    end

  end
end

