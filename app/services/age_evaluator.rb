class AgeEvaluator
  def self.call(condition, appointment)
    dob = appointment["appointment"]["patient"]["date_of_birth"]
    age = (Time.now - Date.parse(dob).to_time) / 60 / 60 / 24 / 365
    age.send(condition["operator"], condition["value"].to_i)
  end
end
