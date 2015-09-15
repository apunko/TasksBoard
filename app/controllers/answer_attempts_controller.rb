class AnswerAttemptsController < ApplicationController
  def index
    @all = AnswerAttempt.all
  end
end
