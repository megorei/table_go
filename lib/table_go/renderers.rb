module TableGo
  module Renderers
    autoload :RendererBase, 'table_go/renderers/renderer_base'
    autoload :HtmlRenderer, 'table_go/renderers/html_renderer'
    autoload :CsvRenderer, 'table_go/renderers/csv_renderer'
    autoload :XlsxRenderer, 'table_go/renderers/xlsx_renderer'
  end
end