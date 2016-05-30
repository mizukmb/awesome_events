require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    it '空白のとき validation エラーになること' do
      should validate_presence_of(:name)
    end

    it '50文字以下であること' do
      should validate_length_of(:name).is_at_most(50)
    end
  end

  describe '#place' do
    it '空白のとき validation エラーになること' do
      should validate_presence_of(:place)
    end

    it '100文字以下であること' do
      should validate_length_of(:place).is_at_most(100)
    end
  end

  describe '#content' do
    it '空白のとき validation エラーになること' do
      should validate_presence_of(:content)
    end

    it '2000文字以下であること' do
      should validate_length_of(:content).is_at_most(2000)
    end
  end

  describe '#start_time' do
    it '空白のとき validation エラーになること' do
      should validate_presence_of(:start_time)
    end
  end

  describe '#end_time' do
    it '空白のとき validation エラーになること' do
      should validate_presence_of(:end_time)
    end
  end


  describe 'start_time が end_time' do
    let(:old_time) { DateTime.new(2000, 4, 1) }
    let(:new_time) { DateTime.new(2016, 4, 1) }
    context 'よりも前にあるとき' do
      let(:event) { Event.new(start_time: old_time, end_time: new_time) }
      it 'valid であること' do
        event.valid?
        expect(event.errors[:start_time]).to be_blank
      end
    end

    context 'と同じとき' do
      let(:event) { Event.new(start_time: new_time, end_time: new_time) }
      it 'valid でないこと' do
        event.valid?
        expect(event.errors[:start_time]).to be_present
      end
    end

    context 'よりも後にあるとき' do
      let(:event) { Event.new(start_time: new_time, end_time: old_time) }
      it 'valid でないこと' do
        event.valid?
        expect(event.errors[:start_time]).to be_present
      end
    end
  end
end
