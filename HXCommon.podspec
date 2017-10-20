Pod::Spec.new do |spec|
spec.name         = 'HXCommon'
spec.version      = '0.0.3'
spec.license      = { :type => 'MIT' }
spec.homepage     = 'https://github.com/Makeanamesohard/HXCommon'
spec.authors      = { 'eric' => '337192133@qq.com' }
spec.summary      = 'version 0.0.3'
spec.source       = { :git => 'https://github.com/Makeanamesohard/HXCommon.git', :tag =>'0.0.3'  }
spec.platform     = :ios, '7.0'
spec.vendored_frameworks = 'HXCommonSDK/HXCommon.framework'
spec.frameworks   = 'Foundation'
end
