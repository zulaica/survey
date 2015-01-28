require('spec_helper')
  describe(Question) do
    it("belongs to a survey") do
      survey = Survey.create({:title => "Random Rhetorical Questions!"})
      question = Question.create({:inquiry => "Whatcha talkin' about Willis?", survey_id: survey.id})
      expect(question.survey()).to(eq(survey))
    end
  end
