class QueryController < ApplicationController
  before_action :allow_params
  def submit
    result = Parser::Parser.new(params).parse
    # url = "https://external-api-gateway.development.carecloud.com/v2/#{params['primaryScope']}" + query_string
    # puts "URL: " + url
    # response = HTTParty.get(url, headers: header)

    render json: result.as_json
  end
  def allow_params
    if params[:conditions]
      params.require(:conditions).permit!
    end
  end
end
