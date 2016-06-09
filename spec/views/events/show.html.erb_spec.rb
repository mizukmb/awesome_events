require 'rails_helper'

RSpec.describe "events/show", type: :view do
  context '存在するイベントページにアクセスしたとき' do
    let(:event) { create :event }

    before do
      visit event_path(event.id)
    end

    it '@event の情報が表示されている' do
      expect(page).to have_text(event.name)
      expect(page).to have_text(event.owner.nickname)
      expect(page).to have_text(event.start_time.strftime('%Y/%m/%d %H:%M'))
      expect(page).to have_text(event.end_time.strftime('%Y/%m/%d %H:%M'))
      expect(page).to have_text(event.place)
      expect(page).to have_text(event.content)
    end
  end

  context '存在しないイベントページにアクセスしたとき' do
    before do
      visit event_path(0)
    end

    it 'nothing と表示される' do
      expect(page).to have_text('nothing')
    end
  end
end
