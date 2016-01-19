require 'rails_helper'

RSpec.describe IpApi, type: :model, vcr: true do
  let(:location) { IpApi.new }
  let(:locationfail) { IpApi.new('127.0.0.1') }
  it 'successfully receives json data about location' do
    expect(location.data['status']).to eq('success')
  end

  it 'fails on invalid ip' do
    expect(locationfail.data['status']).to eq('fail')
  end
end
