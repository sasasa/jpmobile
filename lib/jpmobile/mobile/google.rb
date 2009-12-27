# =Googleモバイルクローラー

module Jpmobile::Mobile
  # ==Googleモバイルクローラー
  class Google < AbstractMobile
    autoload :IP_ADDRESSES, 'jpmobile/mobile/z_ip_addresses_google'

    PRIORITY = 10 #誤認識されないよう優先度を上げておく

    USER_AGENT_REGEXP = %r{Googlebot-Mobile}

    # 本来クッキーをサポートしているか。
    # だがロボットに透過セッションIDが振られると困るのでtrueとする
    def supports_cookie?
      return true
    end
  end
end
