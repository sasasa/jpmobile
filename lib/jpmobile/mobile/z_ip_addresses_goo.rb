# = IPアドレス帯域テーブル(手動更新分)
# == Gooモバイルクローラー
# http://help.goo.ne.jp/help/article/1142/
# 2009/12/25現在
#:enddoc:

Jpmobile::Mobile::AAAGoo::IP_ADDRESSES = %w(
210.150.10.32/27
203.131.250.0/24
203.131.251.0/24
203.131.252.0/24
203.131.253.0/24
203.131.254.0/24
203.131.255.0/24
).map {|ip| IPAddr.new(ip) }
