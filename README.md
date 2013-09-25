# TableGo

simple, flexible and fast html table generator


## Installation

Add this line to your application's Gemfile:

    gem 'table_go'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install table_go


## Usage

example in HAML

    = table_go_for @orders, Order, :title => 'one Table',
        :table_html => { :id => :the_table },
        :row_html   => { :class => lambda { cycle('even', 'odd') },
                         :id => lambda { |record| dom_id(record, :special) }} do |t|

      - t.column :id,
                 :column_html => { :class => lambda { |record, column, value| value.even? ? :even : :odd } }

      - t.column :my_type,
                 :send => :titleize

      - t.column :vat,
                 :label => 'as percent',
                 :as => :percent

      - t.column :price,
                 :label => 'as € currency',
                 :as => :currency

      - t.column :date_of_order,
                 :header_html => { :class => :date, :style => :xyz, :id => :date_column },
                 :column_html => { :class => :date,
                                   :style => :xyz,
                                   :id => lambda { |record, column, value| "date_#{record.id}" }}

      - t.column :date_of_order,
                 :as => :date,
                 :as_options => { :format => :short }

      - t.column :date_of_order,
                 :label  => 'with custom formatter',
                 :as => lambda { |value, record, column| value.to_s.reverse }

      - t.column :date_of_order,
                 :label => 'with block level custom formatter' do |value, record, column|
            %b do it
            %br
            = value
            %b like u want


      - t.column :xmas_bonus,
                 :as => :boolean,
                 :label => 'as boolean'

      - t.column :customer,
                 :method => :name





## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
