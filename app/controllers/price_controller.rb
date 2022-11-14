# frozen_string_literal: true

class PriceController < ApplicationController
  def find_prices
    response = Crawler::PricesService.run(params[:symbol])

    render json: response
  end
end
