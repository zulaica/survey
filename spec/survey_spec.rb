require('spec_helper')

describe('Survey') do
  it("has many questions") do
    question = Question.create({:inquiry => "What's the deal with that?"})
    survey = Survey.create({:questions => [question]})
    expect(survey.questions()).to(eq([question]))
  end
end
