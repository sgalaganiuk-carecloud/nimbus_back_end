class StatusEvaluator
  def self.call(condition, appointment)
    status = appointment["appointment"]["appointment_status"]["name"]
    status.downcase == condition["status"].split(' ').join('-')
  end
end
