# encoding: UTF-8
require 'spec_helper'


describe TableGo::Renderers::HtmlRenderer do

  let(:articles) do
    [ Article.new(:title => 'iPutz',
        :date_of_order => Date.new(2012), :ident => 1, :vat => 19, :price => 5, :xmas_bonus => true,
        :my_type => 'super_type'),
      Article.new(:title => 'Nutzbook',
        :date_of_order => Date.new(2012), :ident => 2, :vat => 19, :price => 5, :xmas_bonus => false,
        :my_type => 'hardware_type') ]
  end

  let(:template) { action_view_instance }

  describe 'automatic mode' do

    subject { TableGo.render_html(articles, Article, template, {}) }

    it 'should render a simple automatic html table' do
      subject.cleanup_html.should eql %Q(
        <table>
          <thead>
            <tr>
              <th>Ident</th>
              <th>Title</th>
              <th>Date of order</th>
              <th>Vat</th>
              <th>Price</th>
              <th>Xmas bonus</th>
              <th>My type</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>iPutz</td>
              <td>2012-01-01</td>
              <td>19</td>
              <td>5</td>
              <td>true</td>
              <td>super_type</td>
            </tr>
            <tr>
              <td>2</td>
              <td>Nutzbook</td>
              <td>2012-01-01</td>
              <td>19</td>
              <td>5</td>
              <td>false</td>
              <td>hardware_type</td>
            </tr>
          </tbody>
        </table>
      ).cleanup_html
    end

  end


  describe 'custom mode' do
    subject do
      TableGo.render_html(articles, Article, template,
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

        t.column :info_text,
                 :label => 'with block level custom formatter' do |value, record, column|

            "a special<br/>value"

        end

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
      subject.cleanup_html.should eql %Q(
        <table id="articles">
          <caption>one Table</caption>
          <thead>
            <tr>
              <th>Ident</th>
              <th>as percent</th>
              <th>as € currency</th>
              <th class="date" id="date_column" style="xyz">Date of order</th>
              <th>Date of order</th>
              <th>with custom formatter</th>
              <th>with block level custom formatter</th>
              <th>as boolean</th>
              <th>My type</th>
            </tr>
          </thead>
          <tbody>
            <tr class="row_css_class" id="row_1">
              <td class="odd">1</td>
              <td>19.000%</td>
              <td>$5.00</td>
              <td class="date" id="date_1" style="xyz">2012-01-01</td>
              <td>Jan 01</td>
              <td>10-10-2102</td>
              <td>a special<br/>value</td>
              <td>&#10004;</td>
              <td>Super Type</td>
            </tr>
            <tr class="row_css_class" id="row_2">
              <td class="even">2</td>
              <td>19.000%</td>
              <td>$5.00</td>
              <td class="date" id="date_2" style="xyz">2012-01-01</td>
              <td>Jan 01</td>
              <td>10-10-2102</td>
              <td>a special<br/>value</td>
              <td>&#10008;</td>
              <td>Hardware Type</td>
            </tr>
          </tbody>
        </table>
      ).cleanup_html
    end
  end


  describe "block style options" do
    let(:table_with_hash_options) do
      TableGo.render_html(articles, Article, template,
        :title => 'one Table',
        :table_html => { :id => :articles },
        :row_html   => { :class => :row_css_class,
                         :id    => lambda { |record| "row_#{record.ident}" }}) do |t|
        t.column :ident,
                 :column_html => { :class => lambda { |record, column, value| value.even? ? :even : :odd } }
      end
    end

    subject(:table_with_block_options) do
      TableGo.render_html(articles, Article, template) do |t|
        t.title      'one Table'
        t.table_html :id => :articles
        t.row_html   :class => :row_css_class,
                     :id    => lambda { |record| "row_#{record.ident}" }

        t.column :ident,
                 :column_html => { :class => lambda { |record, column, value| value.even? ? :even : :odd } }
      end
    end


    it "should render the same way as with hash style options" do
      subject.should eql table_with_hash_options
    end

  end

end

