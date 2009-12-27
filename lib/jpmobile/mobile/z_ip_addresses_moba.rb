# = IPアドレス帯域テーブル(手動更新分)
# == Mobaモバイルクローラー
# http://crawler.dena.jp/
# 2009/12/25現在
#:enddoc:

Jpmobile::Mobile::Moba::IP_ADDRESSES = %w(
202.238.103.126/32
202.213.221.97/32
).map {|ip| IPAddr.new(ip) }
