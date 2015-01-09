describe ApplicationController do
  
  it 'should have the redirect_back method' do
    expect(ApplicationController.new).to respond_to :redirect_back
  end

  it 'should have the save_referer method' do
    expect(ApplicationController.new).to respond_to :save_referer
  end

  it 'should have the return_to_referer method' do
    expect(ApplicationController.new).to respond_to :return_to_referer
  end

  it 'should have the clear_referer method' do
    expect(ApplicationController.new).to respond_to :clear_referer
  end
end