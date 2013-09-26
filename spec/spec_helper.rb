require 'rubygems'
require 'bundler/setup'
# require 'rails'
require 'rspec'
require 'action_controller'
# require 'active_model'
require 'ostruct'
require 'table_go'
require 'haml'
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


def read_file_from_fixtures_path(file)
  File.read(File.dirname(__FILE__) + '/fixtures/%s' % file)
end