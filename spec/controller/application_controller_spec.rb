describe ApplicationController do
  
  describe 'jump_back methods' do
  
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
  
  describe 'private jump_back classes' do
    
    it 'should not have the OptionsParser class' do
      expect { ApplicationController::OptionsParser.new }.to raise_error
      expect(ApplicationController).not_to respond_to :parse
    end
    
    it 'should not have the RefererInterpreter module' do
      expect(ApplicationController).not_to respond_to :back?
      expect(ApplicationController).not_to respond_to :has_referer?
      expect(ApplicationController).not_to respond_to :is_local?
      expect(ApplicationController).not_to respond_to :host
      expect(ApplicationController).not_to respond_to :uri?
    end
    
    it 'should not have the RedirectionDeterminer class' do
      expect(ApplicationController.new).not_to respond_to :path_determiner
      expect { ApplicationController::RedirectionDeterminer.new }.to raise_error
    end
  end
end