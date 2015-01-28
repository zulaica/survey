require('spec_helper')

describe(Survey) do
  it { should have_many(:questions) }

  it("capitalizes the first letter of the title") do
    survey = Survey.create({:title => "SURVEY TITLE"})
    expect(survey.title()).to(eq("Survey title"))
  end

end
