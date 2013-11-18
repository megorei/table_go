# encoding: UTF-8
require 'spec_helper'

describe TableGo::Renderers::CsvRenderer do

  let(:articles) do
    [ Article.new(:title => 'iPutz',
        :date_of_order => Date.new(2012), :ident => 1, :vat => 19, :price => 5, :xmas_bonus => true,
        :my_type => 'super_type'),
      Article.new(:title => 'Nutzbook',
        :date_of_order => Date.new(2012), :ident => 2, :vat => 19, :price => 5, :xmas_bonus => false,
        :my_type => 'hardware_type') ]
  end

  describe 'automatic mode' do
    subject { TableGo.render_csv(articles, Article, {}) }

    it 'should render a simple automatic csv table' do
      subject.cleanup_csv.should == %Q(
        "Ident";"Title";"Date of order";"Vat";"Price";"Xmas bonus";"My type"
        "1";"iPutz";"2012-01-01";"19";"5";"true";"super_type"
        "2";"Nutzbook";"2012-01-01";"19";"5";"false";"hardware_type"
      ).cleanup_csv
    end
  end

  describe 'automatic mode without title row, render_rows_only => true' do
    subject { TableGo.render_csv(articles, Article, {:render_rows_only => true}) }

    it 'should render a simple automatic csv table' do
      subject.cleanup_csv.should == %Q(
        "1";"iPutz";"2012-01-01";"19";"5";"true";"super_type"
        "2";"Nutzbook";"2012-01-01";"19";"5";"false";"hardware_type"
      ).cleanup_csv
    end
  end

  describe 'automatic mode without_header => true' do
    subject { TableGo.render_csv(articles, Article, {:without_header => true}) }

    it 'should render a simple automatic csv table' do
      subject.cleanup_csv.should == %Q(
        "1";"iPutz";"2012-01-01";"19";"5";"true";"super_type"
        "2";"Nutzbook";"2012-01-01";"19";"5";"false";"hardware_type"
      ).cleanup_csv
    end
  end

  describe 'custom mode' do
    subject do
      TableGo.render_csv(articles, Article,
        :title => 'one Table',
        :table_html => { :id => :articles },
        :row_html   => { :class => :row_css_class,
                         :id    => lambda { |record| "row_#{record.ident}" }}) do |t|

        t.column :ident,
                 :column_html => { :class => lambda { |record, column, value| value.even? ? :even : :odd } }

        t.column :vat,
                 :label => 'as percent',
                 :as => :percent

        t.column :price,
                 :label => 'as € currency',
                 :as => :currency

        t.column :date_of_order,
                 :header_html => { :class => :date, :style => :xyz, :id => :date_column },
                 :column_html => { :class => :date,
                                   :style => :xyz,
                                   :id => lambda { |record, column, value| "date_#{record.ident}" }}

        t.column :date_of_order,
                 :as => :date,
                 :as_options => { :format => :short }

        t.column :date_of_order,
                 :label  => 'with custom formatter',
                 :as => lambda { |value, record, column| value.to_s.reverse }

        # t.column :date_of_order,
        #          :label => 'with block level custom formatter' do |value, record, column|

        #   "a special<br/>value"

        # end

        t.column :xmas_bonus,
                 :as => :boolean,
                 :label => 'as boolean'

        t.column :my_type,
                 :send => :titleize

        # t.column :trader,
        #          :method => :name

      end
    end

    it 'should render a html table', 'with custom attributes' do
      subject.cleanup_csv.should == %Q(
        "Ident";"as percent";"as € currency";"Date of order";"Date of order";"with custom formatter";"as boolean";"My type"
        "1";"19.000%";"$5.00";"2012-01-01";"Jan 01";"10-10-2102";"&#10004;";"Super Type"
        "2";"19.000%";"$5.00";"2012-01-01";"Jan 01";"10-10-2102";"&#10008;";"Hardware Type"
      ).cleanup_csv
    end


  end

end

