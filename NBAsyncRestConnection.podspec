Pod::Spec.new do |s|
  s.name         = "NBAsyncRestConnection"
  s.version      = "1.0.0"
  s.summary      = "A class for performing asynchronous RESTful HTTP connections."
  s.homepage     = "https://github.com/needbee/nbasyncrestconnection"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Josh Justice" => "josh@need-bee.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/needbee/nbasyncrestconnection.git", :tag => s.version.to_s }
  s.source_files = 'src', 'src/**/*.{h,m}'
  s.requires_arc = true
end
