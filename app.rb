require "sinatra"
require "sinatra/reloader"

require "http"
require "json"

get("/") do
  response = HTTP.get("https://api.exchangerate.host/symbols")
  @parsed_response = JSON.parse(response.body.to_s) if response.status.success?

  erb(:root)
end

get("/:from_currency") do
  @from_currency = params.fetch(:from_currency)
  response = HTTP.get("https://api.exchangerate.host/symbols")
  @parsed_response = JSON.parse(response.body.to_s) if response.status.success?
  erb(:from_currency)
end

get("/:from_currency/:to_currency") do
  @from_currency = params.fetch(:from_currency)
  @to_currency = params.fetch(:to_currency)
  response = HTTP.get("https://api.exchangerate.host/convert?from=#{@from
  }&to=#{@to_currency}")
  @parsed_response = JSON.parse(response.body.to_s) if response.status.success?
  erb(:to_currency)
end
