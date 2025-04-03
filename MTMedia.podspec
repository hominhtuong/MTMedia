Pod::Spec.new do |spec|
    spec.name         = "MTMedia"
    spec.version      = "1.0.0"
    spec.summary      = "🚀 A wrapper for FFmpeg to handle media processing without needing to manually configure FFmpeg."
    spec.swift_versions = ['5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.7', '5.8', '5.9']
    spec.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Onone' }

    spec.static_framework = true

    spec.description  = <<-DESC
    MTMedia is a powerful Swift library designed as a temporary replacement for FFmpeg and FFprobe in your iOS projects. If you're looking for a tool to process and analyze media (such as videos and audio) but cannot yet use the official FFmpeg libraries, MTMedia provides the perfect solution. 🚀
    DESC

    spec.homepage     = "https://cocoapods.org/pods/MTMedia"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author       = { "Mitu Ultra" => "support@mituultra.com" }
    spec.platform     = :ios, "15.0"
    spec.ios.deployment_target = '15.0'

    spec.source       = { :git => "https://github.com/hominhtuong/MTMedia.git", :tag => "#{spec.version}" }
    spec.source_files = 'Sources/**/*.{h,m,swift}'

    spec.dependency 'MiTuKit'
    spec.exclude_files = 'Sources/xcframework/**/*Headers', 'Sources/xcframework/**/*.h'
    spec.vendored_frameworks = [
 	  'Sources/xcframework/ffmpegkit.xcframework',
	  'Sources/xcframework/libswscale.xcframework',
	  'Sources/xcframework/libavformat.xcframework',
	  'Sources/xcframework/libavutil.xcframework',
	  'Sources/xcframework/libavdevice.xcframework',
	  'Sources/xcframework/libavfilter.xcframework',
	  'Sources/xcframework/libswresample.xcframework',
	  'Sources/xcframework/libavcodec.xcframework'
	]


end
