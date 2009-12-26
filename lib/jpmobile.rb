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
    autoload :Willcom,   'jpmobile/mobile/willcom'
    autoload :Ddipocket, 'jpmobile/mobile/willcom'
    autoload :AAAYahoo,    'jpmobile/mobile/yahoo'
    autoload :AAAGoogle,   'jpmobile/mobile/google'
    autoload :AAALivedoor, 'jpmobile/mobile/livedoor'
    autoload :AAAGoo,      'jpmobile/mobile/goo'
    autoload :AAAFroute,   'jpmobile/mobile/froute'
    autoload :AAAMoba,     'jpmobile/mobile/moba'
    
    def self.carriers
      @carriers ||= constants.sort
    end

    def self.carriers=(ary)
      @carriers = ary.sort
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
