class AppointmentEvaluator

  def initialize(queryObject)
    @primary_scope = queryObject[:primaryScope]
    @conditions = repair queryObject[:conditions]
  end

  def call
    get_initial_set
    @set.select do |appointment|
      @conditions.all? do |condition|
        ConditionEvaluator.call(condition, appointment)
      end
    end
  end

  def get_initial_set
    header = {'Authorization' => 'Bearer kW6y-82hOIFXT1_ayY3G70aG9WOy6cfL'}
    @set = HTTParty.get('https://external-api-gateway.development.carecloud.com/v2/appointments', headers: header)
    @set.map! do |a| 
      a["balance"] = HTTParty.get("https://external-api-gateway.development.carecloud.com/v2/patients/#{a["appointment"]["patient"]["id"]}/balance", headers: header)
      a
    end
  end







  def self.call(queryObject)
    new(queryObject).call
  end

  def repair conditionsObject
    result = []
    conditionsObject.to_a.each do |a|
      k, v = a
      result[k.to_i] = v
    end
    result
  end

end
