class ConditionEvaluator
  EVALUATOR_MAP = {
    "age" => AgeEvaluator
    "balance" => BalanceEvaluator
  }

  def self.call(condition, appointment)
    EVALUATOR_MAP[condition[:type]].call(condition, appointment)
  end
end
