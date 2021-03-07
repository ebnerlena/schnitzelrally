# frozen_string_literal: true

# multiple choice model class
class MultipleChoice < GameTask
  def answers=(val)
    super(val)
    parse_answers
  end

  def parse_answers
    return unless answers.is_a? String

    splitted = answers.split(',')
    self.answers = { 'answers' => { a: splitted[0], b: splitted[1], c: splitted[2], d: splitted[3] } }
  end

  def correct_answers
    cnt = 0
    answers.each do |key, value|
      cnt += 1 if key != 'answers' && (value.downcase == solution.downcase)
    end
    cnt
  end
end
