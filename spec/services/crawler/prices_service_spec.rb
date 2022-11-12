# frozen_string_literal: true

RSpec.describe Crawler::PricesService do
  subject(:api) { described_class }

  it 'does a HTTParty request' do
    expect(api.new('ai')).to eq('ai')
  end
end
