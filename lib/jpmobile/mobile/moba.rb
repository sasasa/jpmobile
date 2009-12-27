# =Mobaモバイルクローラー

module Jpmobile::Mobile
  # ==Mobaモバイルクローラー
  class Moba < AbstractMobile
    autoload :IP_ADDRESSES, 'jpmobile/mobile/z_ip_addresses_moba'

    PRIORITY = 10 #誤認識されないよう優先度を上げておく

    USER_AGENT_REGEXP = %r{moba-crawler}

    # 本来クッキーをサポートしているか。
    # だがロボットに透過セッションIDが振られると困るのでtrueとする
    def supports_cookie?
      return true
    end
  end
end
