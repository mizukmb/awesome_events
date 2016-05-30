require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(50) }
  end
end
