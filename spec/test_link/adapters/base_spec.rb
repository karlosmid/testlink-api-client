#    This file is part of testlink-api-client.
#
#    testlink-api-client is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    testlink-api-client is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with testlink-api-client.  If not, see <http://www.gnu.org/licenses/>.

require "test_link/adapters/base"
require "test_link/exceptions/error_response_exception"
require "test_link/exceptions/empty_response_exception"

describe TestLink::Adapters::Base do
  before :each do
    @adapter = TestLink::Adapters::Base.new
  end

  it "manages responses" do
    expect(@adapter).to provide :response
  end

  it "raises an exception when an error code is detected in the response" do
    @adapter.response = [{"code"=> 2000, "message"=>"Can not authenticate client: invalid developer key"}]
    expect { @adapter.adapt }.to raise_exception TestLink::Exceptions::ErrorResponseException, "Can not authenticate client: invalid developer key"
  end

  it "raises an exception when response is empty" do
    @adapter.response = []
    expect { @adapter.adapt }.to raise_exception TestLink::Exceptions::EmptyResponseException, "Response is empty"
  end

  it "raises an exception when response is nil" do
    @adapter.response = nil
    expect { @adapter.adapt }.to raise_exception TestLink::Exceptions::EmptyResponseException, "Response is empty"
  end

  it 'calls adapt_row' do
    def @adapter.adapt_row row
    end
    @adapter.response = [{'name' => 'a'}, {'name' => 'b'}]
    @adapter.response.each { |row| allow(@adapter).to receive(:adapt_row).with(row) }
    @adapter.adapt
  end

  it 'recognises when a command failed' do
    @adapter.response = {"status_ok" => 0, 'id' => 0, 'msg' => msg = 'Rorem ipsum erroor sit amet'}
    expect { @adapter.adapt }.to raise_exception TestLink::Exceptions::CommandFailedException, "Command has failed: #{msg}"
  end
end