# 雨の日に天気を教えてくれるLINEbot
## 作成手順
MVCモデルに従って作成
作成したコードをherokuにデプロイ

## それぞれのファイル及びコードについて
### db/migrate/db/migrate/20210924060757_create_users.rb
マイグレーションファイル(データベースを生成する際の設計図になるもの。実行すると記述した内容に基づいたデータテーブルが生成される。)となっています。
usersデーブルを作成し
そこにLineIDを格納するためにline_idという名前のstringカラム(テーブルの列の部分,文字列が２５５字までの制限)を作成します。
また、値は絶対に入れなければならないためnull: falseでnullにならないように記述

### lib/tasks/scheduler.rake
雨が降るかどうか調べてメッセージを送るという機能の内容が記されています。
.to_i　→データ型をinteger（整数）型に変換

## class,メソッドについての説明
- open-uri→http/ftp（ファイルを送受信する際のプロトコル） に簡単にアクセスするためのクラスでrubyのライブラリの一つ。
- Kconv→文字コードエンコーディング(データを一定の規則に基づいて符号化すること,他の形式に変更すること)を変換するためのモジュール（単独でも機能するが何かと組み合わせて使用されることが多いもの）
- multicast→userIdsを使用して複数のユーザーにメッセージを送信するメソッド
