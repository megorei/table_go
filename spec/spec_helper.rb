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
end


class Article < OpenStruct
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def self.column_names
    [:id, :title]
  end

end