class QueryController < ApplicationController
  before_action :allow_params
  def submit
    header = {'Authorization' => 'Bearer kW6y-82hOIFXT1_ayY3G70aG9WOy6cfL'}
    query_string = Parser::Parser.new(params).parse
    url = "https://external-api-gateway.development.carecloud.com/v2/#{params['primaryScope']}" + query_string
    puts "URL: " + url
    response = HTTParty.get(url, headers: header)
    render json: response.body.to_json
  end
  def allow_params
    if params[:conditions]
      params.require(:conditions).permit!
    end
  end
end
