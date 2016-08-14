class BalanceEvaluator
  def self.call(condition, appointment)
    patient_id = appointment["appointment"]["patient"]["id"]
    header = {'Authorization' => 'Bearer kW6y-82hOIFXT1_ayY3G70aG9WOy6cfL'}
    balance = HTTParty.get("https://external-api-gateway.development.carecloud.com/v2/patients/#{patient_id}/balance", headers: header)
    total_balance = balance.map { |b| b["total"].to_i }.reduce(:+)
    condition["operator"] = "==" if condition["operator"] == "="
    total_balance.send(condition["operator"], condition["value"].to_i)
  end
end
