require 'rubygems'
require 'bundler/setup'
require 'rails'
require 'rspec-rails'
require 'action_controller'
# require 'active_model'
require 'ostruct'
require 'table_go'
require 'minimal'

RSpec.configure do |config|
  # some (optional) config here
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

