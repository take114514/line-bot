# 雨の日に天気を教えてくれるLINEbot
## 作成手順
## MVCモデルに従って作成
## 作成したコードをherokuにデプロイ
## それぞれのファイルの説明
### db/migrate/db/migrate/20210924060757_create_users.rb
usersデーブルを作成し
そこにLineIDを格納するためにline_idという名前のstringカラム(テーブルの列の部分,文字列が２５５字までの制限)を作成
