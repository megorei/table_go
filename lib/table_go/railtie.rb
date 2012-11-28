module TableGo
  class Railtie < Rails::Railtie
    initializer 'table_go.helpers' do
      ActionView::Base.send :include, Helpers
    end
  end
end
