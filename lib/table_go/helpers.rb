module TableGo
  module Helpers

    def table_go_for(collection, model_klass, options = {}, &block)
      capture do
        if request && request.format.csv?
          TableGo.render_csv(collection, model_klass, options, &block).html_safe
        else
          TableGo.render_html(collection, model_klass, self, options, &block)
        end
      end
    end

  end
end
