# = IPアドレス帯域テーブル(手動更新分)
# == Googleモバイルクローラー
# http://googlejapan.blogspot.com/2008/05/google.html
# 2009/12/25現在
#:enddoc:

Jpmobile::Mobile::Google::IP_ADDRESSES = %w(
72.14.199.0/25
209.85.238.0/25
).map {|ip| IPAddr.new(ip) }
