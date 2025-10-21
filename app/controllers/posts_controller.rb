class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @board = Board.find(params[:board_id])
    @post  = @board.posts.build(post_params.merge(user: current_user))

    if @post.save
      # Turbo Stream で一覧に追加
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @board, success: "投稿しました。" }
      end
    else
      # show の下部にエラーメッセージを出したいとき
      @posts = @board.posts.includes(:user).order(:created_at)
      render "boards/show", status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @post  = @board.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @board, success: "削除しました。" }
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end