require "faraday"
require "cgi"

class Telegram
  def initialize
    @chat_id = ENV["TELEGRAM_CHAT_ID"]
    @token = ENV["TELEGRAM_BOT_TOKEN"]
    @base_url = "https://api.telegram.org"
  end

  def send_message(message)
    Faraday.post("#{@base_url}/bot#{@token}/sendMessage", {
                   chat_id: @chat_id,
                   text: CGI.escapeHTML(message),
                   parse_mode: "HTML"
                 })
  end
end
