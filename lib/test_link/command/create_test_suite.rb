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

require 'test_link/command/base'
require 'test_link/adapters/status_adapter'

module TestLink
  module Command
    class CreateTestSuite < Base
      remote_method

      argument :testprojectid, :mandatory => true
      argument :testsuitename, :mandatory => true
      argument :details, :mandatory => true
      argument :checkduplicatedname
      argument :actiononduplicatedname
      argument :parentid
      argument :order

      adapt_with TestLink::Adapters::StatusAdapter
    end
  end
end