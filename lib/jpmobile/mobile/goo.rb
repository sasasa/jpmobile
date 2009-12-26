# =Gooモバイルクローラー

module Jpmobile::Mobile
  # ==Gooモバイルクローラー
  class AAAGoo < AbstractMobile
    autoload :IP_ADDRESSES, 'jpmobile/mobile/z_ip_addresses_goo'

    USER_AGENT_REGEXP = %r{mobile goo;}

    # 本来クッキーをサポートしているか。
    # だがロボットに透過セッションIDが振られると困るのでtrueとする
    def supports_cookie?
      return true
    end
  end
end
