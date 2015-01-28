require('spec_helper')

describe('Survey') do
  it("has many questions") do
    question = Question.create({:inquiry => "What's the deal with that?"})
    survey = Survey.create({:title => ""})
  end
end
