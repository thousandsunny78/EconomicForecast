# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def shared_pods
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!
  
  # Pods for BaseMVVM
  #Load image
  pod 'Kingfisher', '~> 6.2.1'
  #Keyboard
  pod 'IQKeyboardManagerSwift', '~> 6.5.6'
  # Network
  pod 'Moya/RxSwift', '~> 14.0.0'
  #pod 'RxAlamofire'
  #Parser
  pod 'ObjectMapper', '~> 3.1'
  # Reactive
  #pod 'RxSwift'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  # Auto Layout
  pod 'SnapKit', '~> 5.0.0'
  # Dialog
  pod 'MBProgressHUD', '~> 1.1.0'
  # Logger
  pod 'SwiftyBeaver', '~> 1.9.5'
  # Keychain
  pod 'KeychainAccess', '~> 4.2.2'
end

target 'BaseMVVM' do
  shared_pods
end

target 'BaseMVVM_prod' do
  shared_pods
end
