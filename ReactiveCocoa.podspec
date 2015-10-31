Pod::Spec.new do |s|
  s.name = 'ReactiveCocoa'
  s.version = '4.0.1-alpha-3'
  s.summary = 'A framework for composing and transforming streams of values.'
  s.description = <<-EOS
    ReactiveCocoa (RAC) is an Objective-C framework for Functional Reactive Programming.
    It provides APIs for composing and transforming streams of values.
  EOS
  s.homepage = 'https://github.com/ReactiveCocoa/ReactiveCocoa'
  s.license = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author = {"Josh Abernathy" => "josh@github.com"}
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.source = {
    :git => 'https://github.com/ReactiveCocoa/ReactiveCocoa.git',
    :tag => 'v4.0.0-alpha.3'
  }
  s.dependency 'Result', '~> 0.6-beta.1'
  s.default_subspec = 'UI'

  s.subspec 'no-arc' do |ss|
    ss.source_files = 'ReactiveCocoa/Objective-C/RACObjCRuntime.{h,m}'
    ss.requires_arc = false
    ss.framework = 'Foundation'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'ReactiveCocoa/**/*.{d,h,m,swift}'
    ss.exclude_files = [
      '**/ReactiveCocoa.h',
      'ReactiveCocoa/**/*{RACObjCRuntime,AppKit,NSControl,NSText,NSTable,UIActionSheet,UIAlertView,UIBarButtonItem,UIButton,UICollectionReusableView,UIControl,UIDatePicker,UIGestureRecognizer,UIImagePicker,UIRefreshControl,UISegmentedControl,UISlider,UIStepper,UISwitch,UITableViewCell,UITableViewHeaderFooterView,UIText,MK}*'
    ]
    ss.header_dir = 'ReactiveCocoa'
    ss.private_header_files = [
      '**/*Private.h',
      '**/*EXTRuntimeExtensions.h',
      '**/RACEmpty*.h'
    ]
    ss.framework = 'Foundation'
    ss.dependency 'ReactiveCocoa/no-arc'

    ss.watchos.exclude_files = '**/NSURLConnection*'
    ss.watchos.pod_target_xcconfig = {'GCC_PREPROCESSOR_DEFINITIONS' => 'DTRACE_PROBES_DISABLED=1'}
  end

  s.subspec 'UI' do |ss|
    ss.dependency 'ReactiveCocoa/Core'

    ss.ios.source_files = [
      '**/ReactiveCocoa.h',
      'ReactiveCocoa/**/*{UIActionSheet,UIAlertView,UIBarButtonItem,UIButton,UICollectionReusableView,UIControl,UIDatePicker,UIGestureRecognizer,UIImagePicker,UIRefreshControl,UISegmentedControl,UISlider,UIStepper,UISwitch,UITableViewCell,UITableViewHeaderFooterView,UIText,MK}*'
    ]
    ss.ios.framework = 'UIKit'

    ss.osx.source_files = [
      '"**/ReactiveCocoa.h',
      'ReactiveCocoa/**/*{AppKit,NSControl,NSText,NSTable}*'
    ]
    ss.osx.framework = 'AppKit'
  end
end
