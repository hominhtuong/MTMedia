# MTMedia
[![Version](https://img.shields.io/cocoapods/v/MTMedia.svg?style=flat)](https://cocoapods.org/pods/MTMedia)
[![License](https://img.shields.io/cocoapods/l/MTMedia.svg?style=flat)](https://cocoapods.org/pods/MTMedia)
[![Platform](https://img.shields.io/cocoapods/p/MTMedia.svg?style=flat)](https://cocoapods.org/pods/MTMedia)

## About  
HI,  
MTMedia is a temporary alternative to FFmpeg, providing a seamless way to execute FFmpeg commands while we wait for a better free library with improved support. 🚀  

## Editing Demo 🎬

<p align="center">
    <img src="Resources/cover.jpeg" width="39%" style="margin-right: 16px;">
    <img src="Resources/video.gif" width="39%" style="margin-left: 16px;">
</p>

<p align="center">
    <figure style="display: block; text-align: center; margin-top: 16px;">
        <figcaption>Result</figcaption>
        <img src="Resources/result.gif" width="79%">
    </figure>
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

You can `import ffmpegkit` into your project, or you can use it as shown in the sample project within this repository.

##### Merge image to Video:

```swift
    func mergeVideo() async -> URL? {
        //... setup input, output path
        
        let command =
            "-i \(videoPath) -i \(imagePath) -filter_complex \"[1:v]scale=1280:720[img];[0:v][img]overlay=0:0:enable='between(t,0,2)'\" -c:a copy \(outputPath)"

        guard let session = await MTMedia.execute(command) else {
            return nil
        }

        if session.isSuccess() {
            return await video2GIF(inputUrl: outputUrl)
        } else {
            return nil
        }
    }

```

##### Convert Video to Gif:

```swift
    func video2GIF(inputUrl: URL) async -> URL? {
        //... setup output path
        
        let command =
            "-i \(inputPath) -vf \"fps=20,scale=640:360:flags=lanczos\" -c:v gif \(outputPath)"

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
