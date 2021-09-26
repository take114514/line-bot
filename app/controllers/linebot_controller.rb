class LinebotController < ApplicationController
    require 'line/bot' # gem 'line-bot-api'
    require 'open-uri'
    require 'kconv'
    require 'rexml/document'

    def callback
        body = request.body.read
        signature = request.env['HTTP_X_LINE_SIGNATURE']
        unless client.validate_signature(body, signature)
            return head :bad_request
            end
            events = client.parse_events_from(body)
            events.each { |event|
             case event
                # メッセージが送信された場合の対応(機能①)
             when Line::Bot::Event::Message
                    }