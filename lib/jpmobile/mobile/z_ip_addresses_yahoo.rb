# = IPアドレス帯域テーブル(手動更新分)
# == Yahooモバイルクローラー
# http://help.yahoo.co.jp/help/jp/search/indexing/indexing-27.html
# 2009/12/25現在
#:enddoc:

Jpmobile::Mobile::AAAYahoo::IP_ADDRESSES = (
  [].tap{|ips| 146.upto(185){|n| ips << "124.83.159.#{n}/32" } } +
  [].tap{|ips| 224.upto(247){|n| ips << "124.83.159.#{n}/32" } }
).map {|ip| IPAddr.new(ip) }
