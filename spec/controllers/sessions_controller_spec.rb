require 'spec_helper'

describe SessionsController, type: :controller do
  describe "GET 'new'" do
    it 'returns http success' do
      visit signin_path
      expect(response).to be_success
    end
  end
end
