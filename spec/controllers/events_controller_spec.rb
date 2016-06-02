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

  describe 'POST #create' do
    before do
      user = create :user
      session[:user_id] = user.id
    end

    context 'イベント作成が成功したとき' do
      let(:event) { attributes_for(:event) }
      subject { post :create, event: event }

      it 'ステータスコードとして200を返すこと' do
        expect(response.status).to eq 200
      end

      it 'DB に新規イベントが格納されている' do
        expect{ subject }.to change(Event, :count).by(1)
      end

      it 'DB に格納した新規イベント情報がフォームに入力した情報と合っている' do
        subject
        expect(assigns(:event).owner_id).to eq session[:user_id]
        expect(assigns(:event).name).to eq event[:name]
        expect(assigns(:event).place).to eq event[:place]
        expect(assigns(:event).start_time).not_to be_nil
        expect(assigns(:event).end_time).not_to be_nil
        expect(assigns(:event).content).to eq event[:content]
      end
    end

    context 'イベント作成が失敗したとき' do
      it 'new テンプレートを render していること' do
        post :create, event: attributes_for(:event, place: nil)
        expect(response).to render_template :new
      end
    end
  end
end
