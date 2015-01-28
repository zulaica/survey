require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/surveys') do
  survey_title = params.fetch("survey_title")
  @survey = Survey.create({:title => survey_title})
  @surveys = Survey.all()
  erb(:index)
end

get('/surveys/:id') do
  @survey = Survey.find(params['id'].to_i())
  #Get 'id' is already in Active Record database for survey
  @questions = @survey.questions()
  #ActiveRecord already knows the relationship, @survey.questions() asks for
  #all questions with the same survey iD.
  erb(:survey)
end

post('/surveys/:id') do
  inquiry = params.fetch("inquiry")
  survey_id = params.fetch("survey_id")
  @question = Question.create({:inquiry => inquiry, :survey_id => survey_id})
  @survey = Survey.find(params['id'].to_i())
  @questions = @survey.questions()
  erb(:survey)
end

patch('/surveys/:id') do
  @survey = Survey.find(params['id'].to_i())
  survey_id =  params.fetch("survey_id")
  #Same view, so we dont ned to fetch from database, just from the views page.
  survey_title = params.fetch("survey_title")
  @survey.update({ :title => survey_title })
  @questions = @survey.questions()
  erb(:survey)
end

delete('/surveys/:id') do
  @survey = Survey.find(params['id'].to_i())
  @survey.delete()
  @survey.questions.delete()
  #You must delete questions associated survey_id, otherwise they just sit in database
  #without an id. Just deleting survey_id does not automatically clear questions in DB.
  @surveys = Survey.all()
  erb(:index)
end

get('/questions/:id') do
  @question = Question.find(params['id'].to_i())
  erb(:question)
end

patch('/questions/:id') do
  @question = Question.find(params['id'].to_i())
  inquiry = params.fetch("inquiry")
  @question.update({:inquiry => inquiry})
  erb(:question)
end

delete('/questions/:id') do
  @question = Question.find(params['id'].to_i())
  survey_id = @question.survey_id()
  @question.delete()
  redirect "/surveys/#{survey_id}"

  #String interpolation needed for the redirect, need double quotes ""
end
