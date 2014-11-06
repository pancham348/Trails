require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
        @session.store_session(@res)
    end

    def render_content(content, type)

        @session.store_session(@res)
    end

    # method exposing a `Session` object
    def session
    	@session ||= Phase4::Session.new(@res)
    end
  end
end
