
Pod::Spec.new do |s|
  s.name             = 'CWAPM'
  s.version="0.1.14"
  s.summary          = 'APP Performance Monitor'
  s.description      = 'APP性能监控'
  s.homepage         = 'https://github.com/JackWchen2015/CWAPM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JackWchen2015' => '576734302@qq.com' }
  s.source           = { :git => 'https://github.com/JackWchen2015/CWAPM.git', :tag => s.version}
  s.source_files = 'CWAPM/Classes/**/*.{h,m}'
  s.ios.deployment_target = '8.0'
  s.public_header_files ='CWAPM/Classes/**/*.h'
  s.dependency 'YYDispatchQueuePool'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
end
