require 'spec_helper'

RSpec.describe 'Bancor integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bnt_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BNT', target: 'ETH', market: 'bancor') }

  it 'fetch pairs' do
    pairs = client.pairs('bancor')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bancor'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bnt_eth_pair)

    expect(ticker.base).to eq 'BNT'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'bancor'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
