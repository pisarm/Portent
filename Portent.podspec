Pod::Spec.new do |s|
  s.name = "Portent"
  s.version = "1.0.0"
  s.summary = "Portent - the last logger you will need!"
  s.homepage = "https://github.com/pisarm/Portent"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Flemming Pedersen" => "flemming@pisarm.dk" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.1"
  s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/pisarm/Portent.git", :tag => s.version }
  s.source_files  = "Sources", "Sources/**/*.swift"
end

