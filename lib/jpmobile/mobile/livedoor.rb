# =Livedoorモバイルクローラー

module Jpmobile::Mobile
  # ==Livedoorモバイルクローラー
  class AAALivedoor < AbstractMobile
    autoload :IP_ADDRESSES, 'jpmobile/mobile/z_ip_addresses_livedoor'

    USER_AGENT_REGEXP = %r{LD_mobile_bot}

    # 本来クッキーをサポートしているか。
    # だがロボットに透過セッションIDが振られると困るのでtrueとする
    def supports_cookie?
      return true
    end
  end
end
