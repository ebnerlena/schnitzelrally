class MultipleChoice < GameTask

    def answers=(val)
        super(val)
        parse_answers
    end

    def parse_answers
        Rails.logger.warn("i am parsing the answers: #{answers} now")

        if self.answers.kind_of? String
            splitted = answers.split(",")
            self.answers = {"answers" => {a: splitted[0], b: splitted[1], c: splitted[2], d: splitted[3]}}
        else
            #self.answers.merge(answers)
        end    
        Rails.logger.warn("after parsing the answers: #{answers}")
    end
end
