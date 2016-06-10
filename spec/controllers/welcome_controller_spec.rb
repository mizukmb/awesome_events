require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  context 'GET #index' do
    context 'イベントが存在するとき' do
      let(:event) { Array.new }
      let(:old_event) { create(:event, start_time: DateTime.new(2000, 1, 1, 1, 1)) }

      before do
        10.times do
          event.push create(:event)
        end
      
        get :index
      end

      subject { assigns[:events] }

      it '@events にイベント情報が含まれている' do
        expect(subject).to be_truthy
        expect(subject.size).to eq event.size
      end

      it '開催期限が過ぎたイベントは含まれない' do
        event.push old_event
        expect(subject).not_to include old_event
      end

      it '昇順にイベントが並んでいる' do
        assigns[:events].each_cons(2) do |val1, val2|
          expect(val1.start_time).to be < val2.start_time
        end
      end
    end

    context 'イベントが存在しないとき' do
      it '@events には何もイベント情報が含まれない' do
        expect(assigns[:events]).to be_nil
      end
    end
  end
end
