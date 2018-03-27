source 'https://github.com/CocoaPods/Specs.git'

def common_pods
  pod 'SwiftLint', '0.23.1'
  pod 'Moya/RxSwift', '11.0.1'
  pod 'TimeIntervals', '~> 1.0.0'
end

def ios_pods
  common_pods
  pod "RMDateSelectionViewController", "~> 2.3.1"
end

def tests_shared_pods
  pod 'RxTest', '4.1.2'
end

target 'Ahgora' do
  platform :ios, '10.0'
  use_frameworks!

  ios_pods

end

target 'AhgoraMacOS' do
  platform :osx, '10.11'
  use_frameworks!

  common_pods

end

target 'AhgoraCore' do
  platform :osx, '10.11'
  use_frameworks!

  common_pods

  target 'AhgoraCoreTests' do
    inherit! :search_paths
    tests_shared_pods
  end

end

target 'AhgoraCoreiOS' do
  platform :ios, '10.0'
  use_frameworks!

  common_pods

end
