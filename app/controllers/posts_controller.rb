#controllerファイルはコマンドで簡単に作成することができる。
#rails generate controller Posts

#スキーマの設定もコマンドで作成する事が出来る
#rails generate model Posts title:string content:text スキーマ作成
#rails db:migrate　テーブルが作成される

class PostsController < ApplicationController

    #コントローラが呼び出される前に実行する。特定のコントローラを指定する事持出来る
    before_action :set_post, only: [:edit, :update, :destroy]

    #ルーティング設定したposts/indexのリクエストの処理内容を記載、ＤＢから取得されるデータを設定する
    def index
        #作成したPostテーブルから全てのデータを取得することが出来るようになる。
        @posts = Post.all
    end

    #新しい投稿を作成ファーム用のコントローラを定義していく　
    def new
        #ポストのインスタンス変数を作成
        @post = Post.new
    end

    #createボタンが押された時に作動するボタンのメソッドを定義していく
    def create
        @post = Post.new(post_params)

        #条件分岐で投稿内容が保存されたときにリダイレクトする、それ以外の場合には投稿ページにとどまる
        # Rails.logger.info "Redirecting to posts_path..."
        if @post.save
            redirect_to posts_path
        else
            render :new
        end
    end

    #特定のIDを持ったHTMLへルーティングするコントローラ作成
    def edit
    end
    
    #editページのアップデート用コントローラ
    def update
        #IDを取得して投稿を更新する
        if @post.update(post_params)
            redirect_to posts_path
        else
            render :edit
        end
    end
    
    def destroy
        @post.destroy
        redirect_to posts_path
    end

    #privateを使用する事で以下の行の記述はpostControllerでしか読みだすことの出来ない関数になる
    private

    #投稿内容をどこから抽出するのか明示的にするどこ（:post のフォーム）　の何（:title, :content）
    def post_params
        #以下以外のパラメータと許可しない設定（ストロングパラメータ）
        params.require(:post).permit(:title, :content)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end
