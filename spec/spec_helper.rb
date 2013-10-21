require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'action_controller'
require 'ostruct'
require 'table_go'
require 'haml'
require 'haml/template/plugin'

# require 'pry'

RSpec.configure do |config|
end



class String
  def cleanup_html
    self.gsub(/\n/,'').gsub(/>\s*</, "><").strip
  end

  def cleanup_csv
    self.strip.gsub(/\n\s*/, "\n")
  end
end


class Article < OpenStruct
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def self.column_names
    [:ident, :title, :date_of_order, :vat, :price, :xmas_bonus, :my_type]
  end
end



def action_view_instance
  ActionView::Base.new.tap do |view|
    view.output_buffer = ActiveSupport::SafeBuffer.new rescue ''
  end
end



def read_file_from_fixtures_path(file)
  File.read(file_fixtures_path(file))
end

def file_fixtures_path(file)
  File.dirname(__FILE__) + '/fixtures/%s' % file
end

def render_haml(file, template, locals)
  Haml::Engine.new(read_file_from_fixtures_path(file)).render(template, locals)
end


ActionView::Template.register_template_handler(:haml, Haml::Plugin)