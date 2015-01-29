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
  @questions = @survey.questions()
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
  survey_title = params.fetch("survey_title")
  @survey.update({ :title => survey_title })
  @questions = @survey.questions()
  erb(:survey)
end

delete('/surveys/:id') do
  @survey = Survey.find(params['id'].to_i())
  @survey.delete()
  @survey.questions.delete()
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
end
