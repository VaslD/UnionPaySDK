Pod::Spec.new do |spec|
  spec.name = "UnionPay"
  spec.summary = "银联云闪付 SDK"
  spec.license = { :type => "MIT" }
  spec.homepage = "https://github.com/VaslD/UnionPaySDK"
  spec.authors = "Yi Ding"

  spec.version = "3.4.6"
  spec.source = { :git => "https://github.com/VaslD/UnionPaySDK.git", :tag => spec.version.to_s }

  spec.ios.deployment_target = "13.0"

  spec.frameworks = "Foundation", "UIKit"
  spec.library = "c++"

  spec.pod_target_xcconfig = {
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64",
  }

  spec.default_subspecs = "Pure"

  spec.subspec "Pure" do |subspec|
    subspec.vendored_frameworks = "Pure/Dynamic/UnionPay.xcframework"
  end

  spec.subspec "PureStatic" do |subspec|
    subspec.vendored_frameworks = "Pure/Static/UnionPay.xcframework"
  end

  spec.subspec "Mini" do |subspec|
    subspec.vendored_frameworks = "Mini/Dynamic/UnionPay.xcframework"
  end

  spec.subspec "MiniStatic" do |subspec|
    subspec.vendored_frameworks = "Mini/Static/UnionPay.xcframework"
  end
end
