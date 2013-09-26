# encoding: UTF-8
require 'spec_helper'

ActionView::Base.send :include, TableGo::Helpers

describe TableGo::Helpers do

  let(:articles) do
    [ Article.new(:title => 'iPutz',
        :date_of_order => Date.new(2012), :ident => 1, :vat => 19, :price => 5, :xmas_bonus => true,
        :my_type => 'super_type'),
      Article.new(:title => 'Nutzbook',
        :date_of_order => Date.new(2012), :ident => 2, :vat => 19, :price => 5, :xmas_bonus => false,
        :my_type => 'hardware_type') ]
  end

  let(:template) { action_view_instance }


  describe 'integration in haml template' do

    let(:subject) do
      Haml::Engine.new(read_file_from_fixtures_path('simple_table.html.haml')).render(template, :articles => articles)
    end


    it "it should render in haml" do
      subject.cleanup_html.should == %Q(
        <table>
          <thead>
            <tr>
              <th>Ident</th>
              <th>Custom single cell</th>
              <th>Custom multiline cell</th>
              <th>Custom single cell with backwards compatibility</th>
            </tr></thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>Ident: 1 - Title: iPutz</td>
              <td>Ident: 1 - Title: iPutz</td>
              <td>Ident: 1</td>
            </tr>
            <tr>
              <td>2</td>
              <td>Ident: 2 - Title: Nutzbook</td>
              <td>Ident: 2 - Title: Nutzbook</td>
              <td>Ident: 2</td>
            </tr>
          </tbody>
        </table>
      ).cleanup_html
    end


  end

end

