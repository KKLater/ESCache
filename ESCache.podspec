Pod::Spec.new do |s|

  s.name         = "ESCache"
  s.version      = "0.0.2"
  s.summary      = "MemoryCache、FileCache with Swift for mac、ios、watchos、tvos."

  s.description  = <<-DESC
                   ESCache is a simple and pure Swift implemented library for memory cache and file cache. It provides you a chance to use pure Swift alternation in your next app.
                   DESC

  s.homepage     = "https://github.com/KKLater/ESCache"
  # s.screenshots  = ""

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors      = { "KKLater" => "lshxin89@126.com" }

  s.swift_version = "5.0"
  s.swift_versions = ['5.0']

  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "10.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "3.0"

  s.source       = { :git => "https://github.com/KKLater/ESCache.git", :tag => s.version }

  s.source_files  = ["Sources/**/*.swift", "Sources/ESCache.h"]
  s.requires_arc = true
end
