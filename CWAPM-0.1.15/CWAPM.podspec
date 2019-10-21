Pod::Spec.new do |s|
  s.name = "CWAPM"
  s.version = "0.1.15"
  s.summary = "APP Performance Monitor"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"JackWchen2015"=>"576734302@qq.com"}
  s.homepage = "https://github.com/JackWchen2015/CWAPM"
  s.description = "APP\u{6027}\u{80fd}\u{76d1}\u{63a7}"
  s.xcconfig = {"OTHER_LDFLAGS"=>"-ObjC"}
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/CWAPM.embeddedframework/CWAPM.framework'
end
