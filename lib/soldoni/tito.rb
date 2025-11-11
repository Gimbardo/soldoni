require 'faraday'

class Tito
  def initialize
    @api_token = ENV["TITO_API_TOKEN"]
    @account = ENV["TITO_ACCOUNT"]
    @event = ENV["TITO_EVENT"]
    @base_url = "https://api.tito.io/v3/"
  end

  def get_ticket_sales
    conn = Faraday.new(url: @base_url) do |f|
      f.request :authorization, 'Bearer', @api_token
      f.response :raise_error
      f.adapter Faraday.default_adapter
    end

    response = conn.get("#{@account}/#{@event}/tickets")
    JSON.parse(response.body)["tickets"]
  end
end
