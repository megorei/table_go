require 'spec_helper'


describe TableGo do

  let(:articles) do
    [ Article.new(:title => 'iPutz', :id => 1),
      Article.new(:title => 'Nutzbook', :id => 2) ]
  end

  let(:template) do
    ActionView::Base.new.tap do |view|
      view.output_buffer = ActiveSupport::SafeBuffer.new rescue ''
    end
  end


  context 'html output' do
    subject { TableGo.render_html(articles, Article, template, {}) }

    it 'should render a simple automatic html table' do
      subject.cleanup_html.should == %Q(
        <table>
          <thead>
            <tr>
              <th>Id</th>
              <th>Title</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>iPutz</td>
            </tr>
            <tr>
              <td>2</td>
              <td>Nutzbook</td>
            </tr>
          </tbody>
        </table>
      ).cleanup_html
    end
  end

end