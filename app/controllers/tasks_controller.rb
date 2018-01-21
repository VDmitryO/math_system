class TasksController < ApplicationController
  def index; end

  def create
    header = { auth_token: session[:auth_token] }
    uri = URI('http://localhost:3000/tasks')
    json_answer = Net::HTTP.post(uri, task_params.to_query, header)
    answer = JSON.parse(json_answer.body)
    if answer['error'] == 'Not Authorized'
      redirect_to authorization_path
    else
      @message = if answer['error'] == 'Invalid parameters'
                   'Ошибка ввода параметров!'
                 else
                   result = answer['result']
                   case result.size
                   when 1
                     format('Ответ: x = %.3f', result[0])
                   when 2
                     format('Ответ: x1 = %.3f, x2 = %.3f',
                            result[0], result[1])
                   else
                     'Данное уравнение не имеет решений!'
                   end
                 end
      render 'result'
    end
  end

  private

  def task_params
    params.permit(:a, :b, :c, :d).to_h
  end
end
