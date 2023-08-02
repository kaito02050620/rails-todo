Rails.application.routes.draw do

# ルーティング設定を行い、controllerを付与。
# http://[::1]:3000/posts　と設定する事が出来る
# 以下のようにするだけで簡単にルーティング設定が出来る

resources :posts, only: [:index, :new, :create, :edit, :update, :destroy]

end
