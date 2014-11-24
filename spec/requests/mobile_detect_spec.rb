require 'spec_helper'
require 'support_segment/mobile_detect'

describe SupportSegment::MobileDetect do

  before :each do
    @subscription = ActiveSupport::Notifications.subscribe("render_template.action_view") do |name, start, finish, id, payload|
      @rendered_template = File.basename(payload[:identifier])
    end
  end

  after :each do
    ActiveSupport::Notifications.unsubscribe(@subscription)
  end

  it "adds the :mobile format if the 'm' subdomain is used" do
    get "http://m.example.com"
    expect(@rendered_template).to eql('index.mobile.erb')
  end
  
  it "sticks to :html format if no subdomain is used" do
    get "http://example.com"
    expect(@rendered_template).to eql('index.html.erb')    
  end

  it "redirects to the m subdomain if the user agent is mobile" do
    iPhone_4_user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A405 Safari/7534.48.3"
    get "http://example.com", {}, {'HTTP_USER_AGENT' => iPhone_4_user_agent}
    expect(response).to redirect_to("http://m.example.com")
  end

  it "redirects any path to the m subdomain if the user agent is mobile" do
    iPhone_4_user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A405 Safari/7534.48.3"
    get "http://example.com/foo", {}, {'HTTP_USER_AGENT' => iPhone_4_user_agent}
    expect(response).to redirect_to("http://m.example.com/foo")
  end


  it "does not redirect to the m subdomain if the :full_site_form_mobile cookie flag is set"

end