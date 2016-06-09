require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe ':authenticate' do
    controller do
      def index
        render :text => 'ok!'
      end
    end


    context 'ログインしているとき' do
      before do
        session[:user_id] = 'test_user'
        get :index
      end

      it 'ok!が返される' do
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

  describe 'GET #show' do
    let(:event) { create :event }

    context 'ログインしていないとき' do
      before do
        get :show, id: event.id
      end

      it 'ログインしていなくても show ページを render する' do
        expect(response).to render_template :show
      end
    end

    context '作成したイベントページに遷移したとき' do
      before do
        user  = create :user
        session[:user_id] = user.id
        get :show, id: event.id
      end

      it 'ステータスコードとして200を返すこと' do
        expect(response.status).to eq 200
      end

      it 'show テンプレートを render していること' do
        expect(response).to render_template :show
      end

      it '@event がイベント情報を持っていること' do
        expect(assigns[:event]).to eq event
      end
    end

    context '作成していないイベントページに遷移したとき' do
      before do
        get :show, id: 0
      end

      it 'ステータスコードとして404を返すこと' do
        expect(response.status).to eq 404
      end

      it 'nothingが返される' do
        expect(response.body).to eq "nothing"
      end

      it '@event には何も入っていない' do
        expect(assigns[:event]).to be_nil
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

      it '作成後、イベント詳細ページにリダイレクトする' do
        subject
        expect(response).to redirect_to event_path(id: assigns(:event).id)
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
