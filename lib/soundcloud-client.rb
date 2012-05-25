module Soundcloud
  VERSION = File.read(File.expand_path("../VERSION", File.dirname(__FILE__))).to_s.strip

  [:API, :Error, :Middleware].each do |konst|
    autoload konst, "soundcloud/#{konst.to_s.downcase}"
  end

end
