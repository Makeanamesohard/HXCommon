Pod::Spec.new do |spec|
spec.name         = 'FlyClipSDK'
spec.version      = '0.0.6'
spec.license      = { :type => 'MIT' }
spec.homepage     = 'https://github.com/Makeanamesohard/FlyClipSDK'
spec.authors      = { 'eric' => '337192133@qq.com' }
spec.summary      = 'version 0.0.6'
spec.source       = { :git => 'https://github.com/Makeanamesohard/FlyClipSDk.git', :tag =>'0.0.6'  }
spec.platform     = :ios, '8.0'
spec.vendored_frameworks = 'FlyClipSDK/FlyClipSDK.framework'
spec.frameworks   = 'UIKit','AVFoundation','CoreMedia','CoreFoundation'
end
