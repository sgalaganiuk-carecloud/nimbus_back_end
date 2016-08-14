class ConditionEvaluator
  EVALUATOR_MAP = {
    "age" => AgeEvaluator
  }

  def self.call(condition, appointment)
    EVALUATOR_MAP[condition[:type]].call(condition, appointment)
  end
end
