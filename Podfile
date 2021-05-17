
platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs'


install! 'cocoapods', :disable_input_output_paths => true

use_frameworks!

target 'AppStoreDemo' do
  
inhibit_all_warnings!

# masonry,Bugly,libwebp,SDWebImage,MJRefresh,ReactiveCocoa
pod 'MJExtension'
pod 'MJRefresh'
pod 'SVProgressHUD'
pod 'SDWebImage'
pod 'Masonry'
pod 'AFNetworking'
    
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
    end
end

        
end
