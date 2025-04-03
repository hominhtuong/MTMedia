// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MTMedia",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "MTMedia",
            targets: ["MTMedia"]
        ),
    ],
    targets: [
        .target(
            name: "MTMedia",
            dependencies: [
                "FFmpegKit",
                "libavcodec",
                "libavdevice",
                "libavfilter",
                "libavformat",
                "libavutil",
                "libswresample",
                "libswscale"
            ],
            path: "Sources",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedLibrary("c++")
            ]
        ),
        .binaryTarget(
            name: "FFmpegKit",
            path: "Sources/xcframework/ffmpegkit.xcframework"
        ),
        .binaryTarget(name: "libavcodec", path: "Sources/xcframework/libavcodec.xcframework"),
        .binaryTarget(name: "libavdevice", path: "Sources/xcframework/libavdevice.xcframework"),
        .binaryTarget(name: "libavfilter", path: "Sources/xcframework/libavfilter.xcframework"),
        .binaryTarget(name: "libavformat", path: "Sources/xcframework/libavformat.xcframework"),
        .binaryTarget(name: "libavutil", path: "Sources/xcframework/libavutil.xcframework"),
        .binaryTarget(name: "libswresample", path: "Sources/xcframework/libswresample.xcframework"),
        .binaryTarget(name: "libswscale", path: "Sources/xcframework/libswscale.xcframework")
    ]
)
