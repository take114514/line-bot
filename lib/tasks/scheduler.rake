desc "This task is called by the Heroku scheduler add-on"
task :update_ feed => :environment do
    require 'line/bot'  #gem 'line-bot-api'
    require 'open-uri'
    require 'kconv'
    require 'rexml/document'

    client ||= Line::Bot::Client.new{ |config|
     config.channel_secret = ENV["LINE_CHANNEL_SECRET" ] 
     config.channel_token = ENV["LINE_CHANNEL_TOKEN" ] 
    }
    