# require 'spec_helper'

# describe "Authenticable Concern" do
#   before do
# 	class FakesController < ApplicationController
# 	  include Authenticable
# 	end
#   end
#   after { Object.send :remove_const, :FakesController }
#   let(:authentication) { FakesController.new }
#   # let(:authentication) { Authentication.new }
#   subject { authentication }

#   describe "#current_user" do
#     before do
#       @user = FactoryGirl.create(:player)
#       request.headers["Authorization"] = @user.auth_token
#       authentication.stub(:request).and_return(request)
#     end
#     it "returns the user from the authorization header" do
#       expect(authentication.current_user.auth_token).to eql @user.auth_token
#     end
#   end
# end