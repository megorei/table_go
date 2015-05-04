require 'table_go/version'
require 'active_support/inflector'
require 'active_support/core_ext/string'
require 'active_support/concern'
require 'action_view'

module TableGo
  autoload :Table, 'table_go/table'
  autoload :Column, 'table_go/column'
  autoload :TableRenderer, 'table_go/table_renderer'
  autoload :Renderers, 'table_go/renderers'
  autoload :Formatter, 'table_go/formatter'
  autoload :Helpers, 'table_go/helpers'
  autoload :Orm, 'table_go/orm'

  def self.render_html(collection, model_klass, template, options = {}, &block)
    render(collection, model_klass, Renderers::HtmlRenderer, template, options, &block)
  end

  def self.render_csv(collection, model_klass, template, options = {}, &block)
    render(collection, model_klass, Renderers::CsvRenderer, template, options, &block)
  end

  def self.render(collection, model_klass, renderer_klass, template, options = {}, &block)
    table     = Table.new(collection.respond_to?(:each) ? collection : [collection], model_klass, options, &block)
    renderer  = TableRenderer.new(table)
    renderer.renderer_klass = renderer_klass
    renderer.template       = template
    renderer.render_template
  end

  def self.formatters
    Formatter.formatters
  end

end


require 'table_go/railtie' if defined?(Rails)