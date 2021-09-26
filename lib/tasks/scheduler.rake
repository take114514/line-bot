desc "This task is called by the Heroku scheduler add-on"
task :update_ feed => :environment do
    require 'line/bot'  #gem 'line-bot-api'
    require 'open-uri'
    require 'kconv'
    #rubyでxmlファイルを読み込むことができるように設定
    require 'rexml/document'

    client ||= Line::Bot::Client.new{ |config|
     config.channel_secret = ENV["LINE_CHANNEL_SECRET" ] 
     config.channel_token = ENV["LINE_CHANNEL_TOKEN" ] 
    }
    
    # 天気情報を記載したxmlファイルを使用
    # 使用したxmlデータ（毎日朝6時更新）：以下URLを入力すれば見ることができます。
    url  = "https://www.drk7.jp/weather/xml/13.xml"
     # xmlデータをパース（利用しやすいように整形）
     # urlの情報を文字列にし、UTF-8(日本語の規定)に変換
      xml  = open( url ).read.toutf8
      doc = REXML::Document.new(xml)
      # パスの共通部分を変数化（area[4]は「東京地方」を指定している）
      xpath = 'weatherforecast/pref/area[4]/info/rainfallchance/'
        # 6時〜12時の降水確率（以下同様）の変数設定
        # 1日を４つの時間に分けて降水確率を表示(24-6時はなし)
         per06to12 = doc.elements[xpath + 'period[2]'].text
         per12to18 = doc.elements[xpath + 'period[3]'].text
         per18to24 = doc.elements[xpath + 'period[4]'].text
         # メッセージを発信する降水確率の下限値の設定
         # どれかの時間帯の降水確率が20%以上であったときメッセージを送信
         #.to_i=integer型に表示
         min_per = 20
         if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
            word1 =
             ["いい朝だね！",
             "今日もよく眠れた？",
             "二日酔い大丈夫？",
             "早起きしてえらいね！",
             "いつもより起きるのちょっとアイアンマンじゃない？"].sample
             word2 = 
             ["気をつけて行ってきてね！アイアンマン！",
             "良い一日を過ごしてね！アイアンマン！",
             "今日も頑張ってね！アイアンマン！",
             "今日も一日楽しんでいこうね！アイアンマン！",
             "楽しいことがありますように。アイアンマン！"].sample
             # 降水確率によってメッセージを変更する閾値の設定
             mid_per = 50
             if per06to12.to_i >= mid_per || per12to18.to_i >= mid_per || per18to24.to_i >= mid_per
                word3 = "今日は雨が降りそうだから傘を忘れないでね！"
            else
                word3 = "今日は雨が降るかもしれないから折りたたみ傘があると安心だよ！"
            end
            # 発信するメッセージの設定
            push =
            "#{word1}\n#{word3}\n降水確率はこんな感じだよ。\n   6〜12時　#{per06to12}％\n　12〜18時　 #{per12to18}％\n　18〜24時　#{per18to24}％\n#{word2}"
            # メッセージの発信先idを配列で渡す必要があるため、userテーブルよりpluck関数を使ってidを配列で取得
            user_ids = User.all.pluck(:line_id)
            message = {
                type: 'text',
                text: push
            }
            # .multicast=Send messages to multiple users using userIds.(userIdsを使用している複数のユーザーにメッセージを送る)
            response = client.multicast(user_ids,message)
            end
            "OK"
            end

            