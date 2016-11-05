require 'spec_helper'

describe ApplicationHelper, type: :controller do
  describe 'flash notifications' do
    it 'returns empty when no flash' do
      expect(js_notifications).to be_empty
    end

    it 'returns info for notice flash' do
      flash[:notice] = 'test'
      expect(js_notifications).to eq "notify.info('test');"
    end

    it 'returns error for error flash' do
      flash[:error] = 'testing'
      expect(js_notifications).to eq "notify.error('testing');"
    end

    it 'handles multiple flash messages' do
      flash[:notice] = 'test'
      flash[:error] = 'testing'
      expect(js_notifications).to eq "notify.info('test');notify.error('testing');"
    end
  end
end
