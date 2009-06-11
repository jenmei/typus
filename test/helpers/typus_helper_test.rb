require 'test/helper'

class TypusHelperTest < ActiveSupport::TestCase

  include TypusHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper
  include ActionController::UrlWriter

  def test_applications
    assert true
  end

  def test_resources
    assert true
  end

  def test_typus_block_when_partial_does_not_exist
    output = typus_block(:resource => 'posts', :location => 'sidebar', :partial => 'pum')
    assert output.nil?
  end

  def test_page_title
    params = {}
    options = { :app_name => 'whatistypus.com' }
    Typus::Configuration.stubs(:options).returns(options)
    output = page_title('custom_action')
    assert_equal 'whatistypus.com - Custom action', output
  end

  def test_header_with_root_path

    # Add root named route
    ActionController::Routing::Routes.add_named_route :root, "/", { :controller => "posts" }

    # ActionView::Helpers::UrlHelper does not support strings, which are returned by named routes
    # link root_path
    self.stubs(:link_to).returns(%(<a href="/">View site</a>))

    output = header
    expected = <<-HTML
<h1>#{Typus::Configuration.options[:app_name]} <small><a href="/">View site</a></small>
</h1>
    HTML

    assert_equal expected, output

  end
  
  def test_header_without_root_path

    # Remove root route from list
    ActionController::Routing::Routes.named_routes.routes.reject! {|key, route| key == :root }

    output = header
    expected = <<-HTML
<h1>#{Typus::Configuration.options[:app_name]} </h1>
    HTML

    assert_equal expected, output

  end

  def test_display_flash_message

    message = { :test => 'This is the message.' }

    output = display_flash_message(message)
    expected = <<-HTML
<div id="flash" class="test">
  <p>This is the message.</p>
</div>
    HTML

    assert_equal expected, output

    message = {}
    output = display_flash_message(message)
    assert output.nil?

  end

  def test_typus_message
    output = typus_message('chunky bacon', 'yay')
    expected = <<-HTML
<div id="flash" class="yay">
  <p>chunky bacon</p>
</div>
    HTML
    assert_equal expected, output
  end

  def test_locales

    options = { :locales => [ [ "English", :en ], [ "Español", :es ] ] }
    Typus::Configuration.stubs(:options).returns(options)

    output = locales('set_locale')
    expected = <<-HTML
<p>Set language to <a href=\"set_locale?locale=en\">english</a>, <a href=\"set_locale?locale=es\">español</a>.</p>
    HTML
    assert_equal expected, output

  end

end