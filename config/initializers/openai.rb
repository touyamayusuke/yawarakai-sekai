OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_API_KEY")
  # 任意: タイムアウト
  config.request_timeout = 20
end