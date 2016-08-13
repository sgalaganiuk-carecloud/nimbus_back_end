class QueryController < ApplicationController
  def submit
    header = {'Authorization' => 'Bearer kW6y-82hOIFXT1_ayY3G70aG9WOy6cfL'}
    conditions = params['conditions']
    query_params = []
    query_string = ""
    if conditions.present?
      same_table_params = conditions.to_h.select do |x|
        x = x.second
        x["type"] == params['primaryScope']
      end
    else
      same_table_params = nil
    end
    if same_table_params.try(:first)
      if same_table_params.first.try(:second)
        query_params.merge(same_table_params[0][1])
      end
    end
    if same_table_params.present?
      query_string = "?" + query_params.to_query
    end
    # same_table_params.delete params['primaryScope']
    url = "https://external-api-gateway.development.carecloud.com/v2/#{params['primaryScope']}" + query_string

    response = HTTParty.get(url, headers: header)
    render json: response.body.to_json
  end
end
