Pod::Spec.new do |s|

  s.name         = "LJNetworkLayer"
  s.version      = "1.8"
  s.summary      = "A generic network layer in iOS with Swift 5 using protocol programming"
  s.description  = "This is an easy setup for networking in iOS without any third party framework. Helps you make GET, POST, DELETE, PUT, etc calls and decode the JSON response to required model type without too much of boilerplate code."
  s.homepage     = "https://github.com/lintocj/LJNetworkLayer"
  s.license      = "MIT"
  s.author       = { "Linto Jacob" => "lintojacob2009@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/lintocj/LJNetworkLayer.git", :tag => "1.8" }
  s.source_files = "LJNetworkLayer/**/*.swift"
  s.swift_version = "5.0"
  s.frameworks = "UIKit"

end
