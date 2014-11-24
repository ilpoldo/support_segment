module SupportSegment::MobileDetect
  class Constraint
        
    def matches?(request)
      return false if request.cookies[:full_site_form_mobile] || request.host.match(/^m./)
      request.user_agent.to_s.match(/Mobile/)
    end
    
  end
  
  
  # the following sucks and it makes sense to be more in control of what routes you want to expose for the mobile experience
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        request = Rack::Request.new(env)
        if request.host.match(/^m./)
          request.params[:format] = :mobile
          request.env["action_dispatch.request.formats"] = [Mime::Type.lookup_by_extension(:mobile)]
        end

        return @app.call(env)
      rescue => exception
        Rails.logger.fatal(
          "\n#{exception.class} (#{exception.message}):\n  " +
          exception.backtrace.join("\n") + "\n\n"
        )
        raise exception
      end
    end

  end
end
