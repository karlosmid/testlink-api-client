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
#    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

require "test_link/adapters/node_adapter"
require "test_link/objects/node"

describe TestLink::Adapters::NodeAdapter do
  before :each do
    @adapter = TestLink::Adapters::NodeAdapter.new
  end

  it "inherits from TestLink::Adapters::Base" do
    TestLink::Adapters::NodeAdapter.should < TestLink::Adapters::Base
  end

  it "should know how to adapt a single row of a response" do
    node = TestLink::Objects::Node.new
    row = { "id" => (node.id = 2).to_s,
            "parent_id" => (node.parent_id = 1).to_s,
            "node_type_id" => (node.type_id = 2).to_s,
            "node_order" => (node.order = 1).to_s,
            "node_table" => node.table = "testsuites",
            "name" => node.name = "First Testsuite"}

    @adapter.adapt_row(row).should == node
  end

  it "should should adapt raw response to Project objects" do
    node1 = TestLink::Objects::Node.new
    node2 = TestLink::Objects::Node.new

    response = [
        { "id" => (node1.id = 2).to_s,
            "parent_id" => (node1.parent_id = 1).to_s,
            "node_type_id" => (node1.type_id = 2).to_s,
            "node_order" => (node1.order = 1).to_s,
            "node_table" => node1.table = "testsuites",
            "name" => node1.name = "First Testsuite"},
        { "id" => (node2.id = 3).to_s,
            "parent_id" => (node2.parent_id = 1).to_s,
            "node_type_id" => (node2.type_id = 2).to_s,
            "node_order" => (node2.order = 2).to_s,
            "node_table" => node2.table = "testsuites",
            "name" => node2.name = "Second Testsuite"}]

    @adapter.response = response
    @adapter.adapt.should == [ node1, node2 ]
  end
end