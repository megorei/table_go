module TableGo
  class Railtie < Rails::Railtie
    initializer 'load_config_initializers' do # TODO check if it's work
      unless Mime::Type.lookup_by_extension(:xlsx)
        Mime::Type.register("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx)
      end
    end

    initializer 'table_go.helpers' do
      ActionView::Base.send :include, Helpers
    end
  end
end
