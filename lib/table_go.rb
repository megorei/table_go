module TableGo
  autoload :Table, 'table_go/table'
  autoload :Columns, 'table_go/columns'
  autoload :Column, 'table_go/column'
  autoload :TableRenderer, 'table_go/table_renderer'
  autoload :Renderers, 'table_go/renderers'
  autoload :Formatter, 'table_go/formatter'
  autoload :Helpers, 'table_go/helpers'


  def self.render_html(collection, model_klass, template, options = {}, &block)
    table = Table.new(collection, model_klass, &block)
    TableRenderer.new(template, table, TableGo::Renderers::HtmlRenderer).render(options)
  end

end

require 'table_go/railtie' if defined?(Rails)