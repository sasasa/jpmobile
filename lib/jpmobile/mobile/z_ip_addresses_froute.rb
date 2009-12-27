# = IPアドレス帯域テーブル(手動更新分)
# == Frouteモバイルクローラー
# http://search.froute.jp/howto/crawler.html
# 2009/12/25現在
#:enddoc:

Jpmobile::Mobile::Froute::IP_ADDRESSES = %w(
60.43.36.253/32
).map {|ip| IPAddr.new(ip) }
