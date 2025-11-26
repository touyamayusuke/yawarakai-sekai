class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @board = Board.find(params[:board_id])
    @post  = @board.posts.build(post_params.merge(user: current_user))

    if @post.save
      # OpenAI APIで優しい内容を生成（失敗しても投稿は成立）
      begin
        client  = OpenAI::Client.new(api_key: ENV["OPENAI_API_KEY"])
        prompt  = "次の文章を、誰も傷つけない柔らかい表現に書き換えてください：\n\n#{@post.body}"

        response = client.chat(parameters: {
          model: "gpt-4o-mini", # ← 推奨の軽量モデル
          messages: [
            { role: "system", content: "あなたは文章を丁寧でやさしい表現に言い換えるアシスタントです。" },
            { role: "user",   content: prompt }
          ],
          temperature: 0.7
        })

        Rails.logger.info("OpenAI gentle mode response: #{response.inspect}")

        gentle_text = response.dig("choices", 0, "message", "content").to_s.strip
        # 応答が空なら元文をそのまま入れるなどのフォールバック
        @post.update(gentle_body: (gentle_text.presence || @post.body))
      rescue => e
        Rails.logger.error("OpenAI gentle mode error: #{e.class} #{e.message}")
        # 失敗してもアプリは進める（gentle_body は空のままでもOK）
      end

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @board, success: "投稿しました。" }
      end
    else
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
