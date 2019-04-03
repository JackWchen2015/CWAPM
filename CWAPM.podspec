
Pod::Spec.new do |s|
  s.name             = 'CWAPM'
  s.version          = '0.1.0'
  s.summary          = 'APP Performance Monitor'
  s.description      = <<-DESC
  简单的APM
                       DESC

  s.homepage         = 'https://github.com/JackWchen2015/CWAPM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JackWchen2015' => '576734302@qq.com' }
  s.source           = { :git => 'https://github.com/JackWchen2015/CWAPM.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'CWAPM/Classes/**/*.{h,m,s}'
  
  # s.resource_bundles = {
  #   'CWAPM' => ['CWAPM/Assets/*.png']
  # }

  s.public_header_files = 'CWAPM/Classes/**/*.{h}'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YYDispatchQueuePool'
end
