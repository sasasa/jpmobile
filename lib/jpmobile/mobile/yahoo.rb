# =Yahooモバイルクローラー

module Jpmobile::Mobile
  # ==Yahooモバイルクローラー
  class AAAYahoo < AbstractMobile
    autoload :IP_ADDRESSES, 'jpmobile/mobile/z_ip_addresses_yahoo'

    USER_AGENT_REGEXP = %r{Y!J-SRD/|Y!J-MBS/}

    # 本来クッキーをサポートしているか。
    # だがロボットに透過セッションIDが振られると困るのでtrueとする
    def supports_cookie?
      return true
    end
  end
end
