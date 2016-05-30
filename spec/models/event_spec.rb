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
end
