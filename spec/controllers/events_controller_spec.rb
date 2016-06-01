require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe ':authenticate' do
    controller do
      def index
        render :text => 'ok!'
      end
    end


    context 'ログインしているとき' do
      it 'ok!が返される' do
        session[:user_id] = 'test_user'
        get :index
        expect(response.body).to eq "ok!"
      end
    end

    context 'ログインしていないとき' do
      before { get :index }
      it 'root_path にリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end

      it '『ログインしてください』というアラートが出る' do
        expect(flash[:alert]).to eq 'ログインしてください'
      end
    end
  end
end
