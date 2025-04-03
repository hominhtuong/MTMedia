# MTMedia
[![Version](https://img.shields.io/cocoapods/v/MTMedia.svg?style=flat)](https://cocoapods.org/pods/MTMedia)
[![License](https://img.shields.io/cocoapods/l/MTMedia.svg?style=flat)](https://cocoapods.org/pods/MTMedia)
[![Platform](https://img.shields.io/cocoapods/p/MTMedia.svg?style=flat)](https://cocoapods.org/pods/MTMedia)

## About  
HI,
MTMedia is a powerful Swift library designed as a temporary replacement for FFmpeg and FFprobe in your iOS projects. If you're looking for a tool to process and analyze media (such as videos and audio) but cannot yet use the official FFmpeg libraries, MTMedia provides the perfect solution. 🚀  

## Editing Demo 🎬

<p align="center">
    <img src="Resources/cover.jpeg" width="39%" style="margin-right: 16px;">
    <img src="Resources/video_thumbnail.jpeg" width="39%" style="margin-left: 16px;">
    <img src="Resources/result.gif" width="100%" style="margin-top: 16px;">
</p>


## Installation with CocoaPods
To integrate MTMedia into your Xcode project using CocoaPods, specify it in your `Podfile`

```ruby
target 'MyApp' do
  pod 'MTMedia'
end
```

## Swift Package Manager
Once you have your Swift package set up, adding MTMedia as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/hominhtuong/MTMedia.git", .upToNextMajor(from: "1.0.0"))
]
```

## Example code:
##### The code would look like this:

```swift
    func mergeVideo() async -> URL? {
        guard
            let videoUrl = Bundle.main.url(
                forResource: "video",
                withExtension: "mp4"
            ),
            let imageUrl = Bundle.main.url(
                forResource: "cover",
                withExtension: "jpeg"
            )
        else {
            printDebug("Cannot find video or image")
            return nil
        }

        guard
            let outputUrl = cacheURL?.appendingPathComponent(
                "\(Date().timeIntervalSince1970).mp4"
            )
        else {
            printDebug("Cannot create output url")
            return nil
        }

        let command =
            "-i \(videoUrl.getPath) -i \(imageUrl.getPath) -filter_complex \"[1:v]scale=1280:720[img];[0:v][img]overlay=0:0:enable='between(t,0,2)'\" -c:a copy \(outputUrl.getPath)"

        guard let session = await MTMedia.execute(command) else {
            return nil
        }

        if session.isSuccess() {
            return await video2GIF(inputUrl: outputUrl)
        } else {
            return nil
        }
    }

    func video2GIF(inputUrl: URL) async -> URL? {
        guard
            let outputUrl = cacheURL?.appendingPathComponent(
                "\(Date().timeIntervalSince1970).gif"
            )
        else {
            printDebug("Cannot create output url")
            return nil
        }
        let command =
            "-i \(inputUrl.getPath) -vf \"fps=20,scale=640:360:flags=lanczos\" -c:v gif \(outputUrl)"

        guard let session = await MTMedia.execute(command) else {
            return nil
        }

        return session.isSuccess() ? outputUrl : nil
    }

    
```


## License

MTMedia is released under the MIT license. See [LICENSE](https://github.com/hominhtuong/MTMedia/blob/main/LICENSE) for more details.  
<br>
My website: [Visit](https://mituultra.com/)
