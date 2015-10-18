Pod::Spec.new do |s|
  s.name         = "GSPasswordInputView"
  s.version      = "1.0.0"
  s.summary      = "GSPasswordInputView is Wechat payment like input view."
  s.description  = <<-DESC
                    GSPasswordInputView is Wechat payment like input view. Simple and easy to use. 
                   DESC
  s.homepage     = "https://github.com/Chren/GSPasswordInputView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Aren" => "aren372@126.com" }
  s.platform = :ios, '7.0'
  s.source = { :git => 'https://github.com/Chren/GSPasswordInputView.git', :tag => '1.0.0' }
  s.source_files = 'GSPasswordInputView/*.{h,m}'
  s.requires_arc = true
end