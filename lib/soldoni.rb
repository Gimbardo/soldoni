# frozen_string_literal: true

require_relative "soldoni/version"
require_relative "soldoni/tito"
require_relative "soldoni/telegram"

require "dotenv"

Dotenv.load if File.exist?(File.expand_path("../.env", __dir__))

module Soldoni
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def fetch_and_notify
      tito = Tito.new
      return unless tito.should_send_daily_message?

      Telegram.new.send_message(tito.daily_message)
    end
  end
end
