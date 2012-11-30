require 'spec_helper'


describe TableGo::Table do

  let(:articles) do
    [ Article.new(:title => 'iPutz'),
      Article.new(:title => 'Nutzbook') ]
  end

  let(:template) do
    ActionView::Base.new.tap do |view|
      view.output_buffer = ActiveSupport::SafeBuffer.new rescue ''
    end
  end


  context 'html output' do
    subject { TableGo.render(articles, Article, template) }

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
              <td>1</td>
              <td>Nutzbook</td>
            </tr>
          </tbody>
        </table>
      ).cleanup_html
    end
  end

end