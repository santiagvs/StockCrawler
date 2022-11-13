# frozen_string_literal: true

Rails.application.routes.draw do
  get '/prices/b3/:symbol', to: 'price#get_prices'
end
