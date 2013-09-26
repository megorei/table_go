require 'table_go/version'

module TableGo
  autoload :Table, 'table_go/table'
  autoload :Columns, 'table_go/columns'
  autoload :Column, 'table_go/column'
  autoload :TableRenderer, 'table_go/table_renderer'
  autoload :Renderers, 'table_go/renderers'
  autoload :Formatter, 'table_go/formatter'
  autoload :Helpers, 'table_go/helpers'


  def self.render_html(collection, model_klass, template, options = {}, &block)
    render(collection, model_klass, TableGo::Renderers::HtmlRenderer, template, options, &block)
  end

  def self.render_csv(collection, model_klass, options = {}, &block)
    render(collection, model_klass, TableGo::Renderers::CsvRenderer, nil, options, &block)
  end

  def self.render(collection, model_klass, renderer_klass, template, options = {}, &block)
    table     = Table.new(collection, model_klass, &block)
    renderer  = TableRenderer.new(table)
    renderer.renderer_klass = renderer_klass
    renderer.template       = template
    renderer.apply_options(options)
    renderer.render_template
  end

  def self.formatters
    Formatter.formatters
  end

end


require 'table_go/railtie' if defined?(Rails)