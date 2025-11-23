require "faraday"
require "time"

class Tito
  TIME_LIMIT = 86_400

  def initialize
    @api_token = ENV["TITO_API_TOKEN"]
    @account = ENV["TITO_ACCOUNT"]
    @event = ENV["TITO_EVENT"]
    @base_url = "https://api.tito.io/v3/"
  end

  def ticket_sales
    return @tickets if @tickets

    conn = Faraday.new(url: @base_url) do |f|
      f.request :authorization, "Bearer", @api_token
      f.response :raise_error
      f.adapter Faraday.default_adapter
    end

    response = conn.get("#{@account}/#{@event}/tickets")
    @tickets = JSON.parse(response.body)["tickets"]
  end

  def daily_ticket_sales
    return @daily_tickets if @daily_tickets

    start_limit = Time.now - TIME_LIMIT
    @daily_tickets = ticket_sales.filter do |ticket|
      next false if ticket["created_at"].nil? || ticket["state"] != "complete"

      data_ticket = Time.parse(ticket["created_at"])
      data_ticket > start_limit
    end
  end

  def daily_message
    <<~TEXT
      📅 Daily Report for your event #{@event}\n
      💸 Total number of tickets sold: #{ticket_sales.count}\n
      🚀 Today you sold #{daily_ticket_sales.count} tickets, here's a list of who bought them:\n
      #{daily_ticket_sales.map { |t| "- #{t["registration_name"]}" }.join("\n")}
    TEXT
  end

  def should_send_daily_message?
    !daily_ticket_sales.count.zero?
  end
end
