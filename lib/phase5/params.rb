require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:

    
    def initialize(req, route_params = {})
        # str1 = parse_www_encoded_form(req.query_string).to_h
        # str2 = parse_www_encoded_form(req.body).to_h
        @params = {}
       

        @params.merge!(route_params)

        if req.query_string
            @params.merge!(parse_www_encoded_form(req.query_string))
        end
        if req.body
            @params.merge!(parse_www_encoded_form(req.body))
        end
            
    end

    def [](key)
        @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
def parse_www_encoded_form(www_encoded_form)
    # params = {}
    result = {}
    key_val_pairs = URI::decode_www_form(www_encoded_form)
    # p "decoded from query string: #{keys}"

    key_val_pairs.each do |key_string, val|
        current_hash = result
        #key_array = ["user", "addr", "street"] 
        #val = "encanto ave"
        #result = {'user' => {'addr' => {'street' => 'encanto ave'}}}
        key_array = parse_key(key_string)
        key_array.each_with_index do |key, idx|
            if idx == key_array.length - 1
                current_hash[key] = val
            else
                current_hash[key] ||= {}
                current_hash = current_hash[key]
                # {'user' => {'addr' => {}}}
            end
        end
    end
    result
end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
        key.split(/\]\[|\[|\]/)
    end
  end
end
