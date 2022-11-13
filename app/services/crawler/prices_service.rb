module Crawler
  class PricesService
    class << self
      BASE_URL = 'https://valorinveste.globo.com/cotacoes/'.freeze

      def run(symbol)
        response = HTTParty.get(BASE_URL)
        stock_data = fetch_symbol_data(symbol, response)
        parse_action_info(stock_data)
      end

      def fetch_symbol_data(symbol, response)
        document ||= Nokogiri::HTML(response.body)
        rows = document.css("tbody.vd-table__body tr[contains('#{symbol}')] td.table-date-value")
        return nil if rows.empty?

        rows.map { |row| row.text.squish }
      end

      def parse_action_info(stock_data)
        data = []
        columns = %i[name code last change last_day]
        currency = columns.zip(stock_data).to_h
        data << currency
      end
    end
  end
end
