OpenAI.configure do |config|
  config.access_token = ENV["OPENAI_API_KEY"]
  # 任意: タイムアウト
  config.request_timeout = 20
end
