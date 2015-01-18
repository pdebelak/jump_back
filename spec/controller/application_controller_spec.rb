describe ApplicationController do
  
  describe 'jump_back methods' do
  
    it 'has the redirect_back method' do
      expect(ApplicationController.new).to respond_to :redirect_back
    end
  
    it 'has the save_referer method' do
      expect(ApplicationController.new).to respond_to :save_referer
    end
  
    it 'has the return_to_referer method' do
      expect(ApplicationController.new).to respond_to :return_to_referer
    end
  
    it 'has the clear_referer method' do
      expect(ApplicationController.new).to respond_to :clear_referer
    end
  end
end