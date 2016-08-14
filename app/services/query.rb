class Query
  SCOPE_EVALUATORS = {
    "appointments" => AppointmentEvaluator,
    "patients" => PatientEvaluator
  }
  def self.call(queryHash)
    SCOPE_EVALUATORS[queryHash[:primaryScope]].call(queryHash)
  end
end
