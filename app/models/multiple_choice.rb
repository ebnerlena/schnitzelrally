class MultipleChoice < GameTask

    def answers=(val)
        super(val)
        parse_answers
    end

    def parse_answers
        if self.answers.kind_of? String
            splitted = answers.split(",")
            self.answers = {"answers" => {a: splitted[0], b: splitted[1], c: splitted[2], d: splitted[3]}}
        end    
    end
end
