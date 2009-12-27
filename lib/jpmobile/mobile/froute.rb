# =Frouteモバイルクローラー

module Jpmobile::Mobile
  # ==Frouteモバイルクローラー
  class Froute < AbstractMobile
    autoload :IP_ADDRESSES, 'jpmobile/mobile/z_ip_addresses_froute'

    PRIORITY = 10 #誤認識されないよう優先度を上げておく

    USER_AGENT_REGEXP = %r{symphonybot[0-9]+\.froute\.jp}

    # 本来クッキーをサポートしているか。
    # だがロボットに透過セッションIDが振られると困るのでtrueとする
    def supports_cookie?
      return true
    end
  end
end
