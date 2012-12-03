module TableGo
  module Helpers

    def table_go_for(collection, model_klass, options = {}, &block)
      # capture { TableGo::Table.new(collection, model_klass, self, &block).render(options) }
      capture { TableGo.render_html(collection, model_klass, self, options, &block) }
    end

  end
end
