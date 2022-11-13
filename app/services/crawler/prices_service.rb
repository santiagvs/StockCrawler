module Crawler
  class PricesService
    class << self
      BASE_URL = 'https://valorinveste.globo.com/cotacoes/'.freeze

      def run(symbol)
        response = HTTParty.get(BASE_URL)
        update_time = price_update_time(response)
        stock_data = fetch_symbol_data(symbol.upcase, response)
        parse_action_info(stock_data, update_time)
      end

      private

      def fetch_symbol_data(symbol, response)
        document ||= Nokogiri::HTML(response.body)
        rows = document.css("tbody.vd-table__body tr[contains('#{symbol}')] td.table-date-value")
        raise UnavailableSymbolError if rows.empty?

        rows.map { |row| row.text.squish }
      end

      def parse_action_info(stock_data, update_time)
        data = []
        columns = %i[name code currency_in_BRL change last_day]
        currency = columns.zip(stock_data).to_h.merge(update_time)
        data << currency
      end

      def price_update_time(response)
        document ||= Nokogiri::HTML(response.body)
        date = document.search('h2.vd-table__desc__title').map(&:text).pop.gsub(/(^Atualizado em: | às)/, '')
        { latest_update: DateTime.strptime(date, '%d/%m/%Y %H:%M').to_time }
      end
    end
  end

  class UnavailableSymbolError < StandardError; end
end
