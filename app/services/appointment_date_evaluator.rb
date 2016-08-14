class AppointmentDateEvaluator
  def self.call(condition, appointment)
    condition["operator"] = "==" if condition["operator"] == "="
    start = appointment["appointment"]["start_time"]
    d = Date.parse(start).to_time
    d = d.to_s.split(" ")[0]
    current = Time.now.to_s.split(" ")[0]
    current.send(condition["operator"], d)
  end
end
