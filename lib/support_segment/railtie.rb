require 'support_segment/mobile_detect'
require 'mime/type'

module SupportSegment
  class Railtie < Rails::Railtie
    initializer "support_segment.configure_rails_initialization" do |app|
      Mime::Type.register_alias "text/html", :mobile
      app.middleware.use MobileDetect::Middleware
    end
  end
end
