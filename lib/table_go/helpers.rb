module TableGo
  module Helpers

    def table_go_for(collection, model_klass, options = {}, &block)
      if request && request.format.csv?
        capture { TableGo.render_csv(collection, model_klass, options, &block).html_safe }
      else
        capture { TableGo.render_html(collection, model_klass, self, options, &block) }
      end
    end

  end
end
