module TableGo
  autoload :Table, 'table_go/table'
  autoload :Columns, 'table_go/columns'
  autoload :Column, 'table_go/column'
  autoload :Formatter, 'table_go/formatter'
  autoload :TemplateBase, 'table_go/template_base'
  autoload :StandardTemplate, 'table_go/standard_template'
  autoload :Helpers, 'table_go/helpers'
end

require 'table_go/railtie' if defined?(Rails)