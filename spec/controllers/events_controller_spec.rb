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

  describe 'GET #new' do
    context 'ログインユーザがアクセスしたとき' do
      before do
        user = create :user
        session[:user_id] = user.id
        get :new
      end

      it 'ステータスコードとして200を返すこと' do
        expect(response.status).to eq 200
      end

      it '@eventに、新規 Event オブジェクトが格納されていること' do
        expect(assigns(:event)).to be_a_new(Event)
      end

      it 'new テンプレートを render していること' do
        expect(response).to render_template :new
      end
    end
  end
end
