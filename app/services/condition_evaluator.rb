class ConditionEvaluator
  EVALUATOR_MAP = {
    "age" => AgeEvaluator,
    "appointment" => AppointmentDateEvaluator,
    "balance" => BalanceEvaluator
    # "provider" => ProviderEvaluator
  }

  def self.call(condition, appointment)
    EVALUATOR_MAP[condition[:type]].call(condition, appointment)
  end
end
