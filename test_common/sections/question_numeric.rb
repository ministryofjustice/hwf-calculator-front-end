require_relative 'question_section'

module Calculator
  module Test
    class QuestionNumericSection < QuestionSection
      element :field, 'input'
      delegate :set, to: :field
    end
  end
end
