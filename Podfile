source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

def common_pods
  pod 'SwiftLint', '0.23.1'
  pod 'Moya/RxSwift', '11.0.1'
end

def ios_pods
  common_pods
end

def tests_shared_pods
  pod 'RxTest', '4.1.2'
end

target 'Ahgora' do
  use_frameworks!

  ios_pods

end

target 'AhgoraCore' do
  use_frameworks!

  common_pods

  target 'AhgoraCoreTests' do
    inherit! :search_paths
    
    tests_shared_pods
  end

end

target 'AhgoraCoreiOS' do
  use_frameworks!

  common_pods

end
