# = IPアドレス帯域テーブル(手動更新分)
# == Livedoorモバイルクローラー
# http://helpguide.livedoor.com/help/search/qa/grp627?id=3399
# 2009/12/25現在
#:enddoc:

Jpmobile::Mobile::AAALivedoor::IP_ADDRESSES = %w(
203.104.254.0/24
).map {|ip| IPAddr.new(ip) }
