
Pod::Spec.new do |s|
  s.name         = "RNJuno"
  s.version      = "1.0.12"
  s.summary      = "RNJuno"
  s.description  = "React Native Bridge para o SDK de criptografia e validação da Juno."
  s.homepage     = "https://github.com/RafaelAlthaus/react-native-juno"
  s.license      = "MIT"
  s.author       = { "Rafael Althaus" => "rafael.althaus@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/RafaelAlthaus/react-native-juno.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "DirectCheckout"

end