require "fakeweb"
require "bugly"

FakeWeb.allow_net_connect = false

RSpec.configure do
  # Gratuitously borrowed from Wynn Netherland's gowalla gem
  def stub_get(url, filename, options={})
    opts = {
      :body => fixture_file(filename),
      :content_type => 'application/xml; charset=utf-8'
    }.merge(options)

    FakeWeb.register_uri(:get, bugly_url(url), opts)
  end

  def stub_post(url, filename, options={})
    opts = {
      :body => fixture_file(filename),
      :content_type => 'application/xml; charset=utf-8'
    }.merge(options)

    FakeWeb.register_uri(:post, bugly_url(url), opts)
  end

  def fixture_file(filename)
    return filename if filename == ''

    file_path = File.expand_path(
      File.dirname(__FILE__) + '/fixtures/' + filename
    )

    File.read(file_path)
  end

  def bugly_url(url)
    url =~ /^http/ ? url : "http://example.bug.ly#{url}"
  end
end
