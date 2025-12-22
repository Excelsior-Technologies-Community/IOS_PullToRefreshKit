// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PullToRefreshKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PullToRefreshKit",
            targets: ["PullToRefreshKit"]
        )
    ],
    targets: [
        .target(
            name: "PullToRefreshKit",
            dependencies: []
        )
    ]
)
