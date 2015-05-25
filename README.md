# README

`npm init`...npm初期化。node_modulesディレクトリとpackage.jsonが作成される。bowerのバージョンを管理する。node_modulesディレクトリは.gitignoreする。

`./node_modules/bower/bin/bower init`...bower初期化。bower.jsonが作成される。javascriptのパッケージのバージョン管理をする。.bowerrcを手動で作成して、bower_componentsが作成されるディレクトリを指定する。

インストールは、`bower install [パッケージ名] --save`...--saveでbower.jsonに自動で追加してくれる。installしたパッケージを使う場合は`require [パッケージ名]`のようにかける。bower_componentsも基本的にパッケージ群となるので.gitignoreする。

gemに[bower-rails](https://github.com/rharriso/bower-rails)があるが、これはよく分からない。Bowerfileを作成して一括インストールできるってこと？あとrakeコマンドでできる？なくてもできるから存在意義がよくわかっていない。