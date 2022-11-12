module Crawler
  class PricesService
    BASE_URL = 'https://valorinveste.globo.com/cotacoes/'.freeze

    def initialize(price_code)
      response = HTTParty.get(BASE_URL)
      match_row(price_code, response)
    end

    def match_row(price_code, response); end
  end
end
