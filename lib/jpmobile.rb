$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

module Jpmobile
  autoload :Email   , 'jpmobile/email'
  autoload :Emoticon, 'jpmobile/emoticon'
  autoload :Position, 'jpmobile/position'
  autoload :RequestWithMobile, 'jpmobile/request_with_mobile'
  autoload :Util,     'jpmobile/util'

  module Mobile
    autoload :Docomo,    'jpmobile/mobile/docomo'
    autoload :Au,        'jpmobile/mobile/au'
    autoload :Softbank,  'jpmobile/mobile/softbank'
    autoload :Vodafone,  'jpmobile/mobile/softbank'
    autoload :Jphone,    'jpmobile/mobile/softbank'
    autoload :Emobile,   'jpmobile/mobile/emobile'
    autoload :Ddipocket, 'jpmobile/mobile/willcom'
    autoload :Willcom,   'jpmobile/mobile/willcom'
    
    autoload :Yahoo,    'jpmobile/mobile/yahoo'
    autoload :Google,   'jpmobile/mobile/google'
    autoload :Livedoor, 'jpmobile/mobile/livedoor'
    autoload :Goo,      'jpmobile/mobile/goo'
    autoload :Froute,   'jpmobile/mobile/froute'
    autoload :Moba,     'jpmobile/mobile/moba'
    
    def self.carriers
      @carriers ||= sorted_carriers(constants)
    end

    def self.carriers=(ary)
      @carriers = sorted_carriers(ary)
    end

    def self.sorted_carriers(array)
      array.map{|name| "Jpmobile::Mobile::" + name }.
            map(&:constantize).sort_by{|c| -c::PRIORITY }.
            map(&:name).map(&:demodulize)
    end

    Rails.logger.debug "---mobile------ \n" + carriers.join(", ")
  end
end

%w(
  jpmobile/version.rb
  jpmobile/mobile/abstract_mobile.rb
  jpmobile/mobile/display.rb
).each do |lib|
  require File.expand_path(File.join(File.dirname(__FILE__), lib))
end

if defined? RAILS_ENV
  Dir[File.expand_path(File.join(File.dirname(__FILE__), 'jpmobile/*.rb'))].sort.each { |lib|
    require lib
  }
end
