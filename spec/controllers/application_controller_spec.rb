require_relative '../spec_helper'

describe ApplicationController do
  it 'should work' do
    expect(ApplicationController.new).to be_an_instance_of ApplicationController
  end
end