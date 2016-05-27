require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    context '空白のとき' do
      let(:event) { Event.new(name: '') }

      it 'valid でないこと' do
        event.valid?
        expect(event.errors[:name]).to be_present
      end
    end
  end
end
