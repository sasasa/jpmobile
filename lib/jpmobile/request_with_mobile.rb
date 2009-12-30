# jpmobile の各機能を提供するモジュール
# envメソッドと、parameter あるいは params メソッドが実装されている必要がある。
# 今のところはRack::RequestとActionController::AbstractRequestに対応しているはず。

module Jpmobile
  module RequestWithMobile
    # 環境変数 HTTP_USER_AGENT を返す。
    def user_agent
      env['HTTP_USER_AGENT']
    end

    # for reverse proxy.
    def remote_addr
      if respond_to? :remote_ip
        return __send__(:remote_ip)
      else
        return ( env["HTTP_X_FORWARDED_FOR"] ? env["HTTP_X_FORWARDED_FOR"].split(',').pop : env["REMOTE_ADDR"] )
      end
    end

    # 環境変数 HTTP_USER_AGENT を設定する。
    def user_agent=(str)
      self.env["HTTP_USER_AGENT"] = str
    end

    # 携帯電話からであれば +true+を、そうでなければ +false+ を返す。
    def mobile?
      mobile != nil
    end

    # 携帯電話の機種に応じて Mobile::xxx を返す。
    # 携帯電話でない場合はnilを返す。
    def mobile
      return @__mobile if @__mobile

      Jpmobile::Mobile.carriers.each do |const|
        c = Jpmobile::Mobile.const_get(const)
        return @__mobile = c.new(self) if c::USER_AGENT_REGEXP && user_agent =~ c::USER_AGENT_REGEXP
      end
      nil
    end

    # session fixation対策 cookieが使えない端末で呼ぶ必要がある
    #
    # ログイン時やログアウト時のリダイレクトのすぐ前で呼ぶ
    # sessionやflashに値を入れる => request.regenerate_session => redirect_to
    #
    # param: session_return_to アクセス制御で元居た場所に戻るためにsessionに覚えさせておくための名前
    def regenerate_session(session_return_to=:return_to)
      if session_record = @env['rack.session.record']
        #:active_record_storeのとき
        old_sessid = session_record.session_id
        tmp_data = session

        # 新たなセッションIDを作成。現在存在するものとは異なるセッションIDとする
        begin
          new_sess_id = ActiveSupport::SecureRandom.hex(16)
        end while session_record.class.find_by_session_id(new_sess_id)

        # ログイン前にアクセスしていたページに戻るために記録していたパスのセションIDも書き換える
        if return_to_path = tmp_data[session_return_to]
         sess_key = session_options[:key]
         tmp_data[session_return_to] = return_to_path.sub(%r|#{sess_key}=[a-z0-9]{32}|){ "#{sess_key}=#{new_sess_id}" }
        end

        session_options[:id] = new_sess_id
        session_record.session_id = new_sess_id
        session_record.data = tmp_data
        #session_record[session_record.class.data_column_name] = session_record.class.marshal(tmp_data)
        new_sess_id
      elsif memcache_server = session_options[:memcache_server]
        #:mem_cache_storeのとき
        tmp_data = session
        old_sessid = session_options[:id]

        @@__memcahe ||= MemCache.new(memcache_server,
                                :namespace=>session_options[:namespace])
        try_num = 0
        while !@@__memcahe.active? && try_num < 6
          @@__memcahe = MemCache.new(memcache_server,
                                  :namespace=>session_options[:namespace])
          try_num += 1
          sleep 0.3
        end

        if @@__memcahe && @@__memcahe.active?
          begin
            new_sess_id = ActiveSupport::SecureRandom.hex(16)
          end while @@__memcahe.get(new_sess_id, true)

          # ログイン前にアクセスしていたページに戻るために記録していたパスのセションIDも書き換える
          if return_to_path = tmp_data[session_return_to]
           sess_key = session_options[:key]
           tmp_data[session_return_to] = return_to_path.sub(%r|#{sess_key}=[a-z0-9]{32}|){ "#{sess_key}=#{new_sess_id}" }
          end

          session_options[:id] = new_sess_id
          @@__memcahe.delete("#{old_sessid}", 1)
          @@__memcahe.add("#{new_sess_id}", tmp_data, session_options[:expire_after], true)
          new_sess_id
        else
          raise MemCache::MemCacheError
        end
      else
        #変更しない
        false
      end
    end
  end
end

