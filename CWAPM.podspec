
Pod::Spec.new do |s|
  s.name             = 'CWAPM'
  s.version="0.1.2"
  s.summary          = 'APP Performance Monitor'
  s.description      = <<-DESC
  简单的APM
                       DESC

  s.homepage         = 'https://github.com/JackWchen2015/CWAPM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JackWchen2015' => '576734302@qq.com' }
  s.source           = { :git => 'https://github.com/JackWchen2015/CWAPM.git', :tag => s.version.to_s }
  s.source_files = 'NAME_OF_POD/Classes/**/*.{h,m}'
  s.ios.deployment_target = '8.0'
  s.public_header_files = 'NAME_OF_POD/Classes/*.h'
  s.requires_arc = true
  s.ios.vendored_framework   = 'NAME_OF_POD/CWAPM.framework'
  s.dependency 'YYDispatchQueuePool'
end
