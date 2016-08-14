require 'httparty'
module Parser
  class Parser
    TABLENAMES = {
      "balance" => "patients",
      "appointments" => "appointments",
      "patients" => "patients",
      "age" => "patients"
    }
    HEADERS = {"Authorization" => "Bearer kW6y-82hOIFXT1_ayY3G70aG9WOy6cfL"}
    def initialize(criteria)
      @criteria = criteria
      @parameters
      @same_table_params
    end

    def mega_mapper(condition)
      TABLENAMES[condition]
    end

    def parse
      if @criteria["conditions"].nil?
        conditions_array = []
      else
        conditions_array = @criteria["conditions"]
      end
      parameters = []
      same_table_params = {}
      conditions_array.each_with_index {|x,i|
        if x[1]
          x[1]["table"] = mega_mapper(x[1]["type"])
        end
        if x[1] && x[1]["table"] == @criteria["primaryScope"]
          x[1].keys.each { |xx|
              if !["table", "type"].include?(xx)
                same_table_params[xx]= x[1][xx]
              end
          }
        else
            x[1] && x[1].keys.each {|xx|
              parameters << {xx => x[1][xx]}
          }
        end
      }
      puts "SAME_TABLE_PARAMS: " + same_table_params.to_s
      get_data(same_table_params)
      #parameters.each { |x|
      #    puts get_data(x)
      #}

    end

    def url(condition)
      puts "condition: " + condition.to_s
      table = @criteria["primaryScope"]
      if !condition.empty? && condition.present?
        query_string = "?" + condition.to_query
      else
        query_string = ""
      end
      ("https://external-api-gateway.development.carecloud.com/v2/" + table + query_string).downcase
     end

    def get_data(condition)
      puts "URL: " + url(condition).to_s
      puts "headers: " + HEADERS.to_s
      HTTParty.get(url(condition).to_s.downcase, headers: HEADERS).body
    end

    def get_ids(data)
      # data = get_data(condition)

       # logic here with data
       # return ids = []
    end

  end
end