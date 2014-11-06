require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    attr_reader :cookie_val
    def initialize(req)
        @cookies = req.cookies
        @cookie_val = {}
        @cookies.each do |cookie|
            if cookie.name == '_rails_lite_app'
                @cookie_val = JSON.parse(cookie.value)
            end
        end
    end

    def [](key)
        @cookie_val[key]
    end

    def []=(key, val)
        @cookie_val[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
        res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie_val.to_json)
        Phase4::Session.new(res)
    end
  end
end
