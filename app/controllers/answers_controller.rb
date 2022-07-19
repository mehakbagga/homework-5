class AnswersController < ApplicationController
    before_action :find_post
  # create / destroy

  def create
    @answer = Answer.new(params.require(:answer).permit(:body))
    @answer.post = @post

    if @answer.save
      redirect_to post_path(@post), notice: "Answer created!"
      # if saved successfully then redirect to the show page of the question
      # otherwise still go to this show page but using render
      # the difference between redirect and render
      # redirect is sending a get request '/questions/:id'
      # render is rendering the page
    else
      # we want to stay on this page
      @answers = @post.answers.order(created_at: :desc)
      # '/questions/show' is not the action
      # it's the page /questions/show.html.erb
      render '/posts/show', status: 303
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    if can?(:crud, @answer)
      @answer.destroy
      redirect_to post_path(@post), notice: "Answer deleted"
    else
      redirect_to root_path, alert: "Not authorized"
    end
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end
end
