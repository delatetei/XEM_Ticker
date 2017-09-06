#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
require 'uri'
require 'net/http'
require 'json'
require 'date'
require 'twitter'

uri = URI.parse("https://api.zaif.jp/api/1/ticker/xem_jpy")
json = JSON.parse(Net::HTTP.get(uri) )

#取引所からみたbid/ask（売り／買い）表記なのでユーザー視点では逆になる
post_str  = Time.now.strftime("[%Y-%m-%d %H:%M:%S]") + " "
post_str += "終値:"   + json["last"].to_s + " "
post_str += "高値:"   + json["high"].to_s + " "
post_str += "安値:"   + json["low"].to_s  + " "
post_str += "VWAP:"   + json["vwap"].to_s  + " "
post_str += "出来高:" + json["volume"].to_s  + " "
post_str += "買値:"   + json["bid"].to_s  + " "
post_str += "売値:"   + json["ask"].to_s  + " "
post_str += "#XEMティッカー"

#twitter投稿用のトークン設定
client = Twitter::REST::Client.new(
  consumer_key:        ENV['XEM_CONSUMER_KEY'],
  consumer_secret:     ENV['XEM_CONSUMER_SECRET'],
  access_token:        ENV['XEM_ACCESS_TOKEN'],
  access_token_secret: ENV['XEM_ACCESS_TOKEN_SECRET']
)

#投稿
client.update("#{post_str}")
