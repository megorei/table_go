module TableGo
  autoload :Table, 'table_go/table'
  autoload :Columns, 'table_go/columns'
  autoload :Column, 'table_go/column'
  autoload :Renderer, 'table_go/renderer'
  autoload :Formatter, 'table_go/formatter'
  autoload :TemplateBase, 'table_go/template_base'
  autoload :StandardTemplate, 'table_go/standard_template'
  autoload :Helpers, 'table_go/helpers'

  def self.render(collection, model_klass, template, options = {}, &block)
    table = Table.new(collection, model_klass, &block)
    Renderer.new(template, table).render(options)
  end

end

require 'table_go/railtie' if defined?(Rails)