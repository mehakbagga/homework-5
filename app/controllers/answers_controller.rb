class AnswersController < ApplicationController
    before_action :find_post
    before_action :authenticate_user!
  # create / destroy

  def create
    @answer = Answer.new answer_params
    @answer.post = @post
    @answer.save
    redirect_to post_path(@post)
  end

  def destroy
    @answer = Answer.find params[:id]
    @answer.destroy
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
