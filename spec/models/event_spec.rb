require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(50) }

    it { should validate_presence_of(:place) }

    it { should validate_length_of(:place).is_at_most(100) }

    it { should validate_presence_of(:content) }

    it { should validate_length_of(:content).is_at_most(2000) }

    it { should validate_presence_of(:start_time) }
  end
end
