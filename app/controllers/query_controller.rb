class QueryController < ApplicationController
  before_action :repair_nested_params
  def submit
    result = Parser::Parser.new(params).parse
    # url = "https://external-api-gateway.development.carecloud.com/v2/#{params['primaryScope']}" + query_string
    # puts "URL: " + url
    # response = HTTParty.get(url, headers: header)

    render json: result.as_json
  end

  def perform
    result = Query.call(params)

    render json: result.as_json
  end

  def allow_params
    if params[:conditions]
      params.require(:conditions).permit!
    end
  end


  protected

  # Fixes nested attribute params for strong_parameters (turns string keyed hash
  # into array of hashes)
  def repair_nested_params(obj = params)
    obj.each do |key, value|
      if value.is_a? Hash
        # If any non-integer keys
        if value.keys.find {|k, _| k =~ /\D/ }
          repair_nested_params(value)
        else
          obj[key] = value.values
          obj[key].each {|h| repair_nested_params(h) }
        end
      end
    end
  end
end
