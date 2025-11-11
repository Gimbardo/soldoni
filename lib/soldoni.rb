# frozen_string_literal: true

require_relative 'soldoni/version'
require_relative 'soldoni/tito'

require "dotenv"

Dotenv.load if File.exist?(File.expand_path("../../.env", __FILE__))

module Soldoni
  class Error < StandardError; end
  # Your code goes here...

  class << self
    def fetch_and_notify
      pp Tito.new.get_ticket_sales["tickets"].map{ |el| [el['registration_name'], el] }
    end

  end
end
