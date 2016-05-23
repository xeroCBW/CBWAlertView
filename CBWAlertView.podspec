Pod::Spec.new do |s|
  s.name         = "CBWAlertView"
  s.version      = "2.0.1"
  s.summary      = "A custom AlertView that can modify color and animation."
  s.homepage     = "https://github.com/xeroxmx/CBWAlertView"
  s.license      = "MIT"
  s.author             = { "codeChenBW" => "861754186@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/xeroxmx/CBWAlertView.git", :tag => "2.0.1" }
  s.source_files  = 'CBWAlertView/**/*.{h,m}'
  s.requires_arc = true

end
